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

if  hyprctl clients 2>/dev/null | grep -q "Notes"; then
    hyprctl dispatch focuswindow class:Notes
  else
  alacritty -T "Notes" --class "Notes" -e nvim --cmd "cd ${HOME}/Workspace/my-notes" \
       $NOTE_FILE_NAME
fi



