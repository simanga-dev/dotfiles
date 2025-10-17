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

tmux display-popup -E "nvim   $NOTE_FILE_NAME"

