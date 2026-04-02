#!/bin/sh

class="$1"
cmd="$2"

window_address=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${class}\") | .address" | head -n 1)

# incase the special window is open... close it
if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
    hyprctl dispatch togglespecialworkspace special
fi

if [ -z "$window_address" ]; then
    $cmd
else
    hyprctl dispatch workspace $(hyprctl clients -j  | jq -r ".[] | select(.class == \"${class}\") .workspace.id" | head -n 1)
    hyprctl dispatch focuswindow "$window_address"
fi

