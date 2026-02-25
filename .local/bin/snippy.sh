#!/bin/sh


pkill -9 -f 'nnn|nchat|btop|clipse|rmpc|fzf-pass|fzf' 2>/dev/null;

sleep 0.1s

SNIPS_FILE=${HOME}/Workspace/my-notes/snippets/snippets.txt

DATA=`sed -r 's/::.*$//g' ${SNIPS_FILE} | fzf`

echo $DATA

if [ -n "$DATA" ]; then
    VALUE=`sed -n "s/^$DATA:://p" $SNIPS_FILE`
    printf "$VALUE" | clip.exe
fi


