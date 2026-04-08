#!/bin/bash

# # Extract hosts from the user's SSH config file
# if [ ! -f "$HOME/.config/servers.txt" ]; then
#     echo "Server config file not found at $HOME/.config/servers.txt."
#     exit 1
# fi

HOSTS=$(rg '^Host ' ~/.ssh/config | sed 's/Host *//')

if [ -z "$HOSTS" ]; then
    echo "No hosts found in the server config file."
    exit 1
fi

# Use fzf to select a server
SERVER_NAME=$(echo "$HOSTS" | fzf --prompt="Select a server: ")

if [ -z "$SERVER_NAME" ]; then
    echo "No server selected."
    exit 1
fi

# SSH logic with tmux
if ! tmux has-session -t "$SERVER_NAME" 2>/dev/null; then
    sesh connect "$SERVER_NAME"
fi

NEW_WINDOW=$(tmux new-window -t "$SERVER_NAME" -P)
tmux send-keys -t "${NEW_WINDOW}" "ssh $SERVER_NAME" Enter
tmux switch-client -t "${NEW_WINDOW}"

killall nnn 2>/dev/null || true
exit 0
