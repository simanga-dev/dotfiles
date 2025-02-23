#!/bin/sh

if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
	if ! tmux has-session -t special 2>/dev/null; then
	   tmux new-session -d -s special
	fi
else
    hyprctl dispatch togglespecialworkspace special
fi


if  tmux list-windows -t special  2>/dev/null | grep -q "Files"; then
	tmux select-window -t Files
  else
  tmux new-window -a -t special -n Files
  tmux send-keys -t special:Files "nnn" Enter
  tmux select-window -t Files
fi



