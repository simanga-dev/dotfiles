#!/usr/bin/env bash

BASE='/home/simanga/'

# for personal files and all that kind of staff I mess with
# items=`fd --max-depth=1 --type=d --base-directory=${BASE} . 'Code'`
# items+=$'\n'
items+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . 'Workspace'`
items+=$'\n'
items+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . '.config'`
items+=$'\n'
items+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . '.local/share/nvim/lazy'`
# items+=$'\n'
# items+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . 'workspace/hackerthon'`

# items+=$'\n'
# for a company specific projects
# items+=`fd -H -I --type=directory --base-directory=/home/hendry/workspace/kriterion -E ".github" "\.git" | sed '\.git/' '' | sed '(^\w)' 'workspace/kriterion/$1'`
items+=$'\n'


if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
    hyprctl dispatch togglespecialworkspace special
fi

FOLDER=`echo "$items" | wofi --dmenu`

if [ -d "${BASE}${FOLDER}" ]; then
     n="$(echo ${FOLDER} | sed 's/\/$//')"
     n="$(echo ${n} | sed 's/\//->/g')"

     PROJECT_NAME="$(echo ${n} | sed 's/.*>//')"

    cd ${BASE}${FOLDER}

    if ! tmux has-session -t special 2>/dev/null; then
	tmux new-session -d -s special
    fi

    if ! tmux list-windows -t special 2>/dev/null | grep -q "${PROJECT_NAME}"; then
	tmux new-window -t special -n ${PROJECT_NAME}
	tmux send-keys -t special:${PROJECT_NAME} "nvim ." Enter
    fi

    if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
	alacritty -T "neovim - $n" --class "NIDE"  -e tmux attach-session -t special:${PROJECT_NAME}
    else
	tmux select-window -t ${PROJECT_NAME}
    fi
    hyprctl dispatch togglespecialworkspace special
fi

