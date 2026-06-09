#!/usr/bin/env bash
set -euo pipefail

# git lfs ls-files marks fetched files with ' * ', pointer-only files with ' - '
lfs_files=$(git lfs ls-files | awk '/ \* / { sub(/^[^ ]+ \* /, ""); print }')

if [ -z "$lfs_files" ]; then
    echo "No fetched git lfs files found"
    exit 0
fi

while IFS= read -r file; do
    echo "Restoring $file"
    jj restore "$file"
done <<< "$lfs_files"
