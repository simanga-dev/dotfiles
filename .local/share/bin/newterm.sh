#!/bin/sh

if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
	if ! tmux has-session -t special 2>/dev/null; then
	   tmux new-session -d -s special
	fi
else
    hyprctl dispatch togglespecialworkspace special
fi

new_window=$(tmux new-window -t special -P)
tmux select-window -t "$new_window"
