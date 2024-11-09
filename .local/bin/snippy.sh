#!/bin/sh

SNIPS_FILE=${HOME}/Workspace/my-notes/snippets/snippets.txt

DATA=`sed -r 's/::.*$//g' ${SNIPS_FILE} | fuzzel -d `

if [[ -n "$DATA" ]]; then
    VALUE=`sed -n "s/^$DATA:://p" $SNIPS_FILE`
    printf "$VALUE" | wl-copy
    printf "$VALUE" | wl-copy -p
    wtype $(wl-paste)
fi
