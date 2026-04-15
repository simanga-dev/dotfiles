#!/bin/bash
# Cycle through open workspaces
# Usage: ./cycle-workspace.sh [next|prev]

direction="$1"

# Check if special workspace is open and close it (same pattern as keybindings.conf)
hyprctl activewindow 2>/dev/null | grep -q "special:special" && hyprctl dispatch togglespecialworkspace special

# Get current workspace
active_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

# Get all open workspaces sorted numerically, filter out special workspaces
open_workspaces=$(hyprctl workspaces -j | jq -r '[.[] | select(.id > 0) | .id] | sort | .[]')

# Convert to array
readarray -t workspaces <<< "$open_workspaces"

# Find current index
for i in "${!workspaces[@]}"; do
    if [[ "${workspaces[$i]}" == "$active_workspace" ]]; then
        current_index=$i
        break
    fi
done

# Calculate next/prev index
count=${#workspaces[@]}

if [[ "$direction" == "next" ]]; then
    next_index=$(( (current_index + 1) % count ))
elif [[ "$direction" == "prev" ]]; then
    next_index=$(( (current_index - 1 + count) % count ))
else
    exit 1
fi

# Dispatch to the workspace
hyprctl dispatch workspace "${workspaces[$next_index]}"
