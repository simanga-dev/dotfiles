#!/bin/sh

URL="$1"

# incase the special window is open... close it
if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
    hyprctl dispatch togglespecialworkspace special
fi

if [ "$(hyprctl activewindow -j | jq -r ".workspace.id")" != "9" ]; then
    hyprctl dispatch workspace 9
fi

zen-browser $URL

