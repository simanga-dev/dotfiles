#!/bin/sh

WEEK_NUMBER=$(date +%V)
YEAR=$(date +%Y)
MONTH=$(date +%m)

NOTE_FILE_NAME="$HOME/Workspace/my-notes/notes/${WEEK_NUMBER}_${MONTH}_${YEAR}.md"

if [ ! -f $NOTE_FILE_NAME ]; then
  echo "## Notes | Year: ${YEAR} | Month: ${MONTH} | Week: ${WEEK_NUMBER}" > $NOTE_FILE_NAME
  echo "

### On my mind 🤯


### Interesting 💭


### Today's Goals 🚀

" >> $NOTE_FILE_NAME

fi

if  hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
	if ! tmux has-session -t special 2>/dev/null; then
	   tmux new-session -d -s special
	fi
else
    hyprctl dispatch togglespecialworkspace special
fi


if  tmux list-windows -t special  2>/dev/null | grep -q "Notes"; then
	tmux select-window -t Notes
  else
  tmux new-window -a -t special -n Notes
  tmux send-keys -t special:Notes "cd   $HOME/Workspace/my-notes" Enter
  tmux send-keys -t special:Notes "nvim   $NOTE_FILE_NAME" Enter
  tmux select-window -t Notes
fi



