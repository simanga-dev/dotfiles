#!/bin/sh

if  hyprctl activewindow 2>/dev/null | grep -q "floating: 0"; then
    hyprctl dispatch cyclenext
else
    hyprctl dispatch layoutmsg cyclenext
fi
