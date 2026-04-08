
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


tmux display-popup -w 80% -h 70%  "/home/simanga/.bun/bin/pi"
