#!/bin/sh

/home/simanga/.local/bin/killpopup.sh

pgrep -a nvim | rg "nvim \/.*my-notes/notes.*md" | sed 's/^\([0-9]*\).*/\1/' | xargs -r kill -9


if ! tmux has-session -t special 2>/dev/null; then
  tmux new-session -d -s special
fi

if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
	alacritty -T "neovim" --class "NIDE" -e tmux attach-session -t special &
	while ! hyprctl clients 2>/dev/null | grep -q "NIDE"; do
		sleep 0.1
	done
fi

if ! hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
	hyprctl dispatch togglespecialworkspace special
fi

# Ensure tmux has had time to register the attached client to prevent crash
sleep 0.2
# Target the special session and use a nested tmux session to prevent yazi from crashing the parent tmux when trying to display image previews
# tmux display-popup -w 80% -h 70% -t special -E "tmux new-session yazi \; set status off"
tmux display-popup -w 80% -h 70% -E "nnn -c"
