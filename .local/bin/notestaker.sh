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


if ! tmux has-session -t default 2>/dev/null; then
    tmux new-session -d -s default
fi


if  tmux list-windows -t default  2>/dev/null | grep -q "Notes"; then
	tmux select-window -t Notes
  else

	tmux new-window -a -t default -n Notes

	tmux send-keys -t default:Notes "nvim   $NOTE_FILE_NAME" Enter

	tmux select-window -t Notes
fi

tmux kill-window -t default:default
