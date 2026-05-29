#!/usr/bin/env bash
set -euo pipefail

if [[ -f "$PWD/towncrier.toml" ]]; then
    towncrier create --config towncrier.toml --dir .
else
    towncrier create --config "$HOME/.config/towncrier/towncrier.toml" --dir .
fi
