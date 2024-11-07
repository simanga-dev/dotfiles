#!/usr/bin/env bash

if ! tmux has-session -t default 2>/dev/null; then
    tmux new-session -d -s default
fi

if ! tmux list-windows -t default 2>/dev/null | grep -q "default"; then
    tmux new-window -t default -n  default
fi

tmux send-keys -t default:default "PASSWORD_STORE_ENABLE_EXTENSIONS=true pass fzf" Enter

tmux select-window -t default

