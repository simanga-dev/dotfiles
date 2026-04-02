#!/usr/bin/env sh

# Description: Fuzzy find and execute scripts in a tmux popup window
# Dependencies: television, find, bat (optional), tmux (optional)

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

SCRIPTDIR="$HOME/.local/bin"
NNNPLUGINSDIR="$HOME/.config/nnn/plugins"

RUN_CMD="\
    if command -v bat >/dev/null 2>&1; then \
        PREVIEW='bat --terminal-width=\$(tput cols) --color=always --style=header,numbers {}'; \
    else \
        PREVIEW='cat {}'; \
    fi; \
    selected=\$(tv \\
        --source-command \"{ find -L \\\"$SCRIPTDIR\\\" -maxdepth 3 -perm -111 -type f 2>/dev/null; find -L \\\"$NNNPLUGINSDIR\\\" -maxdepth 3 -perm -111 -type f 2>/dev/null; }\" \\
        --ansi \\
        --preview-command \"\$PREVIEW\" \\
        --preview-size 60 \\
        --preview-word-wrap \\
        --source-display \"{split:/:-1}\") \\
    && [ -n \"\$selected\" ] && \"\$selected\""

tmux display-popup -w 80% -h 70%  -E "$RUN_CMD"

