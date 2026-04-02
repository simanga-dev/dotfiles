#!/bin/sh


prepare_to_open_project() {
  BASE='/home/simanga/'
  output+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . 'Workspace'`
  output+=$'\n'
  output+=`fd --follow --max-depth=1 --type=d  --base-directory=${BASE} . '.config'`
  output+=$'\n'
  output+=`fd --follow --max-depth=1 --type=d  --base-directory=${BASE} . 'Playground'`
  output+=$'\n'
  # output+=`fd --max-depth=1 --type=d  --base-directory=${BASE} . '.local/share/nvim/lazy'`
  # output+=$'\n'



  FOLDER=`echo "$output" | fzf`

  if [ -n "${FOLDER}" ] && [ -d "${BASE}${FOLDER}" ]; then

       n="$(echo ${FOLDER} | sed 's/\/$//')"
       n="$(echo ${n} | sed 's/\//->/g')"

       PROJECT_NAME="$(echo ${n} | sed 's/.*>//')"

      cd ${BASE}${FOLDER}

      if ! tmux list-windows -t special 2>/dev/null | rg -q "\s${PROJECT_NAME}"; then
        tmux new-window -a -t special -n ${PROJECT_NAME}
        tmux send-keys -t special:${PROJECT_NAME} "nvim ." Enter
        tmux select-window -t ${PROJECT_NAME}
        echo $PROJECT_NAME
      else
        tmux select-window -t ${PROJECT_NAME}
      fi
  fi

    return 0
}


prepare_to_open_project



