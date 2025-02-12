#!/bin/sh

SNIPS_FILE=${HOME}/Workspace/my-notes/snippets/snippets.txt

DATA=`sed -r 's/::.*$//g' ${SNIPS_FILE} | fzf`

if [[ -n "$DATA" ]]; then
    VALUE=`sed -n "s/^$DATA:://p" $SNIPS_FILE`
    printf "$VALUE" | clip.exe
    # printf "$VALUE" | wl-copy
    # wtype -M shift -k Insert -m shift
fi

tmux last-window

tmux kill-window -t default:default

