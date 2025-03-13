#!/usr/bin/env sh

# enable float
WinFloat=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .floating')
WinPinned=$(hyprctl -j clients | jq '.[] | select(.focusHistoryID == 0) | .pinned')

## Only video player not other windo
MediaPlayer=$(hyprctl activewindow -j | jq -r '.initialClass')


if [ "${WinFloat}" == "false" ] && [ "${WinPinned}" == "false" ] && [ "${MediaPlayer}" == "mpv" ]  ; then
    hyprctl dispatch togglefloating active
    hyprctl dispatch resizeactive exact 489 275
    hyprctl dispatch moveactive exact 2000 856
    hyprctl dispatch pin
    hyprctl dispatch cyclenext
else
    if  [ "${MediaPlayer}" == "mpv" ] ; then
        hyprctl dispatch togglefloating active
        hyprctl dispatch fullscreenstate 2 3
    fi
fi

