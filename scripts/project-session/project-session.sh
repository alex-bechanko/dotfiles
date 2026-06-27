#!/usr/bin/env bash

set -euo pipefail

USAGE="Usage: $0 <project-path> <second-pane-command> [args...]"

if [ -z "${1:-}" ]; then
    echo "$USAGE"
    exit 1
fi

case "$1" in
    -h|--help)
        echo "$USAGE"
        echo ""
        echo "Opens a new zellij tab named after the project directory with two panes:"
        echo "  left  - terminal in the project directory"
        echo "  right - command and its arguments"
        exit 0
        ;;
esac

if [ $# -lt 2 ]; then
    echo "$USAGE"
    exit 1
fi

PROJECT_PATH="$(realpath "$1")"
TAB_NAME="$(basename "$PROJECT_PATH")"
shift

TAB_ID="$(zellij action new-tab --name "$TAB_NAME" --cwd "$PROJECT_PATH")"

zellij action new-pane --tab-id "$TAB_ID" --direction right --cwd "$PROJECT_PATH" -- "$@"
