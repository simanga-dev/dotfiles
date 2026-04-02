
#!/bin/sh

SNIPS_FILE=${HOME}/Workspace/my-notes/snippets/snippets.txt

DATA=`sed -r 's/::.*$//g' ${SNIPS_FILE} | fzf`

if [[ -n "$DATA" ]]; then
    VALUE=`sed -n "s/^$DATA:://p" $SNIPS_FILE`
    echo "${VALUE}" | wl-copy
    # hyprctl dispatch togglespecialworkspace special
    # printf "%s" "${VALUE}" | wl-copy -p

fi

 exit 0


