#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <workflow.yaml> [...]" >&2
    exit 1
fi

is_sha() {
    [[ "$1" =~ ^[0-9a-f]{40}$ ]]
}

get_owner_repo() {
    echo "${1%@*}" | cut -d/ -f1,2
}

get_ref() {
    echo "${1##*@}"
}

get_repo_path() {
    echo "${1%@*}"
}

resolve_tag_to_commit() {
    local owner_repo="$1"
    local tag="$2"

    local response obj_type obj_sha
    response=$(gh api "repos/${owner_repo}/git/ref/tags/${tag}" 2>/dev/null) || return 1

    obj_type=$(echo "$response" | jq -r '.object.type')
    obj_sha=$(echo "$response" | jq -r '.object.sha')

    if [[ "$obj_type" == "commit" ]]; then
        echo "$obj_sha"
    elif [[ "$obj_type" == "tag" ]]; then
        gh api "repos/${owner_repo}/git/tags/${obj_sha}" --jq '.object.sha' 2>/dev/null
    fi
}

resolve_sha_to_commit() {
    local owner_repo="$1"
    local sha="$2"

    if gh api "repos/${owner_repo}/git/commits/${sha}" --jq '.sha' 2>/dev/null | grep -q .; then
        echo "$sha"
        return
    fi

    gh api "repos/${owner_repo}/git/tags/${sha}" --jq '.object.sha' 2>/dev/null || true
}

declare -A cache

resolve() {
    local uses="$1"
    if [[ -v cache["$uses"] ]]; then
        echo "${cache[$uses]}"
        return
    fi

    local owner_repo ref commit_sha
    owner_repo=$(get_owner_repo "$uses")
    ref=$(get_ref "$uses")

    if is_sha "$ref"; then
        commit_sha=$(resolve_sha_to_commit "$owner_repo" "$ref")
    else
        commit_sha=$(resolve_tag_to_commit "$owner_repo" "$ref") || true
    fi

    cache["$uses"]="${commit_sha:-}"
    echo "${commit_sha:-}"
}

for file in "$@"; do
    while IFS= read -r grep_line; do
        linenum="${grep_line%%:*}"
        content="${grep_line#*:}"

        # Extract uses value: strip leading whitespace/dash, take part after "uses:", strip comments
        uses=$(echo "$content" | sed 's/.*uses:[[:space:]]*//' | sed 's/[[:space:]]*#.*//' | tr -d '[:space:]')
        [[ -z "$uses" ]] && continue
        [[ "$uses" == ./* ]] && continue

        ref=$(get_ref "$uses")
        repo_path=$(get_repo_path "$uses")
        location="${file}:${linenum}"
        commit_sha=$(resolve "$uses")

        if is_sha "$ref"; then
            if [[ "$commit_sha" == "$ref" ]]; then
                echo "OK     ${location}: $uses"
            elif [[ -n "$commit_sha" ]]; then
                echo "CHANGE ${location}: $uses -> ${repo_path}@${commit_sha}"
            else
                echo "ERROR  ${location}: could not resolve SHA for $uses" >&2
            fi
        else
            if [[ -n "$commit_sha" ]]; then
                echo "PIN    ${location}: $uses -> ${repo_path}@${commit_sha}"
            else
                echo "ERROR  ${location}: could not resolve tag for $uses" >&2
            fi
        fi
    done < <(grep -n 'uses:' "$file")
done
