#!/bin/sh

# Get PiP or mpv floating window
window_address=$(hyprctl clients -j | jq -r '
  [.[] | select(.title == "Picture-in-Picture" or .class == "mpv")]
  | first | .address // empty
')

active_window_address=$(hyprctl activewindow -j | jq -r ".address")

if [ -z "$window_address" ]; then
    exit 0
fi

# Toggle: if already focused on floating window, go back to previous window
if [ "$window_address" = "$active_window_address" ]; then
    hyprctl dispatch focusurgentorlast
else
    hyprctl dispatch focuswindow address:"$window_address"
fi
