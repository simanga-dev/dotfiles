#!/bin/sh

killall nnn
killall rmpc
killall bluetui
killall fzf
killall btop
killall wiremix



WEEK_NUMBER=$(date +%V)
YEAR=$(date +%Y)
MONTH=$(date +%m)

NOTE_FILE_NAME="$HOME/Workspace/my-notes/notes/${WEEK_NUMBER}_${MONTH}_${YEAR}.md"

if [ ! -f $NOTE_FILE_NAME ]; then
  echo "## Notes | Year: ${YEAR} | Month: ${MONTH} | Week: ${WEEK_NUMBER}" > $NOTE_FILE_NAME
  echo "

### TASK

" >> $NOTE_FILE_NAME

fi


if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
	alacritty -T "neovim" --class "NIDE" -e tmux attach-session -t special &
	while ! hyprctl clients 2>/dev/null | grep -q "NIDE"; do
		sleep 0.1
	done
fi

if ! hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
	hyprctl dispatch togglespecialworkspace special
fi

tmux display-popup -w 80% -h 70% -E "nvim -c 'cd $HOME/Workspace/my-notes'  $NOTE_FILE_NAME"

