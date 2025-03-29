#!/bin/sh

BASE_PATH="$HOME/Pictures/Screenshots/Text"

grimblast save area "$BASE_PATH/$(date +%s).png"

LATEST_IMG="$(exa --sort=modified $BASE_PATH | tail -1 )"

tesseract "$BASE_PATH/$LATEST_IMG" stdout | wl-copy 
