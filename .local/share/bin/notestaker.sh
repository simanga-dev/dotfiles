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


if ! tmux has-session -t special 2>/dev/null; then
  tmux new-session -d -s special
fi

NEW_WINDOW="Notes"

if ! tmux list-windows -t special  2>/dev/null | grep -q ${NEW_WINDOW}; then
	tmux new-window -a -t special -n ${NEW_WINDOW}
	tmux send-keys -t special:Notes "cd   $HOME/Workspace/my-notes" Enter
	tmux send-keys -t special:Notes "nvim   $NOTE_FILE_NAME" Enter
fi

if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
	alacritty -T "neovim - $NEW_WINDOW" --class "NIDE"  -e tmux attach-session -t special:${NEW_WINDOW}
else
	if ! hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
		hyprctl dispatch togglespecialworkspace special
	fi
	tmux select-window -t ${NEW_WINDOW}
	tmux attach-session -t ${NEW_WINDOW}
fi
