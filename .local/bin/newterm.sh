#!/bin/sh

ACTIVE_SESSION=$(tmux display-message -p '#{session_name}' 2>/dev/null)

if [ -z "$ACTIVE_SESSION" ]; then
  if ! tmux has-session -t special 2>/dev/null; then
    tmux new-session -d -s special
  fi
  ACTIVE_SESSION="special"
fi

NEW_WINDOW=$(tmux new-window -t "$ACTIVE_SESSION" -P)

if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
  alacritty -T "neovim - $NEW_WINDOW" --class "NIDE"  -e tmux attach-session -t ${NEW_WINDOW}
else

  if ! hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
      hyprctl dispatch togglespecialworkspace special
  fi
  tmux attach-session -t ${NEW_WINDOW}
fi


/home/simanga/.local/bin/killpopup.sh
