#!/bin/sh


window_address=$(hyprctl clients -j | jq -r '.[] | select(.class == "com.github.th_ch.youtube_music") | .address')

# incase the special window is open... close it
if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
    hyprctl dispatch togglespecialworkspace special
fi


if [ -z "$window_address" ]; then
    youtube-music
else
    hyprctl dispatch workspace $(hyprctl clients -j  | jq -r '.[] | select(.class == "com.github.th_ch.youtube_music") .workspace.id')
    hyprctl dispatch focuswindow "$window_address"
fi

