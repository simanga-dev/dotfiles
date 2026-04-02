#!/bin/sh

BASE_PATH="$HOME/Pictures/Screenshots"

grim -g "$(slurp)" "$BASE_PATH/$(date +%s).png"

LATEST_IMG="$(exa --sort=modified $BASE_PATH | tail -1)"

tesseract "$BASE_PATH/$LATEST_IMG" stdout | tee | wl-copy
