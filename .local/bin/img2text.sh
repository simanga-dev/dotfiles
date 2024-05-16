#!/bin/sh

BASE_PATH="$HOME/Pictures/Screenshots"

maim -m 10 --select "$BASE_PATH/$(date +%s).png"

LATEST_IMG="$(exa --sort=modified $BASE_PATH | tail -1 )"

tesseract "$BASE_PATH/$LATEST_IMG" stdout | tee | xclip -selection clipboard
