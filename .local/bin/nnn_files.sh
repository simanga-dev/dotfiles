#!/bin/sh

if ! tmux has-session -t default 2>/dev/null; then
    tmux new-session -d -s default
fi


if  tmux list-windows -t default  2>/dev/null | grep -q "NNN-Files"; then
	tmux select-window -t NNN-Files
  else
	tmux new-window -a -t default -n NNN-Files

	tmux send-keys -t default:NNN-Files "nnn -c" Enter

	tmux select-window -t NNN-Files
fi
