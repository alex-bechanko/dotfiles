#!/usr/bin/env bash
set -euo pipefail

xdg_config="${XDG_CONFIG_HOME:-$HOME/.config}"

if [[ -f "$PWD/towncrier.toml" ]]; then
    config="$PWD/towncrier.toml"
elif [[ -f "$xdg_config/towncrier/towncrier.toml" ]]; then
    config="$xdg_config/towncrier/towncrier.toml"
elif [[ -f "$HOME/.towncrier.toml" ]]; then
    config="$HOME/.towncrier.toml"
else
    echo "towncrier: no config file found"
    exit 1
fi

towncrier create --config "$config" --dir .
