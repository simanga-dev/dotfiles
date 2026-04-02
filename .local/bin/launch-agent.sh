#!/bin/sh

PROJECT_NAME="a-$(echo $(pwd) | md5sum | cut -d' ' -f1)"

if ! tmux has-session -t special 2>/dev/null; then
  tmux new-session -d -s special
fi

if ! tmux list-windows -t special 2>/dev/null | grep -q "${PROJECT_NAME}"; then
    tmux new-window -t special -n ${PROJECT_NAME}
    tmux send-keys -t special:${PROJECT_NAME} "gemini " Enter
else
    tmux select-window -t "${PROJECT_NAME}"
fi

