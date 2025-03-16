#!/usr/bin/env sh

# Check if the active window is floating and pinned
WinFloat=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .floating')
WinPinned=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .pinned')

# Get the class of the active window
PiPCheck=$(hyprctl activewindow -j | jq -r 'select(.initialClass == "mpv")')
PiPCheck=+$(hyprctl activewindow -j | jq -r 'select(.class == "zen") | select(.title == "Picture-in-Picture")')

# Function to toggle floating and adjust the window size/position
toggle_floating_and_resize() {
    hyprctl dispatch togglefloating active
    hyprctl dispatch resizeactive exact 489 275
    hyprctl dispatch moveactive exact 2000 856
    hyprctl dispatch pin
    hyprctl dispatch cyclenext
}

# Function to toggle floating and set fullscreen state
toggle_floating_and_fullscreen() {
    hyprctl dispatch togglefloating active
    hyprctl dispatch fullscreenstate 2 3
}

# Main logic
if [ "${WinFloat}" = "false" ] && [ "${WinPinned}" = "false" ] && [ -n "${PiPCheck}" ]; then
    toggle_floating_and_resize
elif  [ -n "${PiPCheck}" ]; then
    toggle_floating_and_fullscreen
fi
