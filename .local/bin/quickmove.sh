#!/usr/bin/env bash

BASE='/home/simanga/'

# for personal files and all that kind of staff I mess with
# items=`fd --max-depth=1 --type=d --base-directory=${BASE} . 'Code'`
# items+=$'\n'
items+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . 'workspace'`
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



FOLDER=`echo "$items" | rofi -dmenu`

    echo ${FOLDER}

if [ -d "${BASE}${FOLDER}" ]; then
	n="$(echo ${FOLDER} | sed 's/\/$//')"
	n="$(echo ${n} | sed 's/\//->/g')"

	PROJECT_NAME="$(echo ${n} | sed 's/.*>//')"

	echo ${n}
	echo ${PROJECT_NAME}

	cd ${BASE}${FOLDER}

	tmux new-session -d -s ${PROJECT_NAME}

	tmux send-keys -t ${PROJECT_NAME} "nvim ." Enter
	tmux attach-session -t ${PROJECT_NAME}

	alacritty -T "neovim - $n" --class "NIDE"  -e tmux attach-session -t ${PROJECT_NAME}
fi

# echo "$items" | fzf | xargs -I {} nvim {} --cmd 'cd {}'
