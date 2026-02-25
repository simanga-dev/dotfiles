#!/bin/bash
 
# # Extract hosts from the user's SSH config file
# if [ ! -f "$HOME/.config/servers.txt" ]; then
#     echo "Server config file not found at $HOME/.config/servers.txt."
#     exit 1
# fi
 
HOSTS=$(cat ~/.ssh/config | rg '^Host ' | sed 's/Host//'  )
 
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
if [ -n "$TMUX" ] && tmux list-sessions 1>/dev/null 2>&1; then
    if ! tmux has-session -t "${SERVER_NAME}" 2>/dev/null; then
        tmux new-session -d -s "${SERVER_NAME}" "ssh $SERVER_NAME"
    fi
    tmux switch-client -t "${SERVER_NAME}"
else
    nohup bash -c "ssh $SERVER_NAME" &
fi

killall nnn
