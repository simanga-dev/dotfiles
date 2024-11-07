#!/bin/sh

SNIPS_FILE=${HOME}/Workspace/my-notes/snippets/snippets.txt

DATA=`sed -r 's/::.*$//g' ${SNIPS_FILE} | wofi --dmenu`

if [[ -n "$DATA" ]]; then
    VALUE=`sed -n "s/^$DATA:://p" $SNIPS_FILE`
    printf "$VALUE" | wl-copy -p
    printf "$VALUE" | wl-copy
    wtype -M shift -k Insert -m shift
fi
