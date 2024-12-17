#!/bin/sh

if ! tmux has-session -t default 2>/dev/null; then
    tmux new-session -d -s default
fi


if  tmux list-windows -t default  2>/dev/null | grep -q "Music"; then
	tmux select-window -t Music
  else
	tmux new-window -a -t default -n Music

	tmux send-keys -t default:Music "mpd $NOTE_FILE_NAME" Enter
	tmux send-keys -t default:Music "ncmpcpp   $NOTE_FILE_NAME" Enter

	tmux select-window -t Music
fi

