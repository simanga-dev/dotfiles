#!/bin/sh


if ! tmux has-session -t special 2>/dev/null; then
  tmux new-session -d -s special
fi

NEW_WINDOW="Files"

if ! tmux list-windows -t special  2>/dev/null | grep -q ${NEW_WINDOW}; then
	tmux new-window -a -t special -n ${NEW_WINDOW}
	tmux send-keys -t special:${NEW_WINDOW} "nnn" Enter
fi

if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
	alacritty -T "neovim - $NEW_WINDOW" --class "NIDE"  -e tmux attach-session -t special:${NEW_WINDOW}
else
	if ! hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
		hyprctl dispatch togglespecialworkspace special
	fi
	tmux select-window -t ${NEW_WINDOW}
	tmux attach-session -t ${NEW_WINDOW}
fi
