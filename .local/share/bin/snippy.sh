#!/usr/bin/env sh

#* jq to parse and create a metadata.
#* Users are advised to use bindd to explicitly add the description
#* Please inform us if there are new Categories upstream will try to add comments to this script
#* Khing 🦆

pkill -x rofi && exit
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh"

confDir="${XDG_CONFIG_HOME:-$HOME/.config}"
keyconfDir="$confDir/hypr"

roDir="$confDir/rofi"
roconf="$roDir/clipboard.rasi"

HELP() {
  cat <<HELP
Usage: $(basename "$0") [options]
Options:
    -j     Show the JSON format
    -p     Show the pretty format
    -d     Add custom delimiter symbol (default '>')
    -f     Add custom file
    -w     Custom width
    -h     Custom height
    --help Display this help message
Example:
 $(basename "$0") -j -p -d '>' -f custom_file.txt -w 80 -h 90"
Users can also add a global overrides inside ${hydeConfDir}/hyde.conf
  Available overrides:

    kb_hint_delim=">"                         ﯦ add a custom custom delimiter
    kb_hint_conf=("file1.conf" "file2.conf")  ﯦ add a custom keybinds.conf path (add it like an array)
    kb_hint_width="30em"                      ﯦ custom width supports [ 'em' '%' 'px' ]
    kb_hint_height="35em"                     ﯦ custom height supports [ 'em' '%' 'px' ]
    kb_hint_line=13                           ﯦ adjust how many lines are listed

Users can also add a key overrides inside ${hydeConfDir}
List of file override:
${keycodeFile} => keycode
${modmaskFile} => modmask
${keyFile} => keys
${categoryFile} => category
${dispatcherFile} => dispatcher

Example for keycode override
create a file named $keycodeFile and use the following format:

    "number": "display name/symbol",
    "61": "/",

HELP
}

SNIPS_FILE=${HOME}/Workspace/my-notes/snippets/snippets.txt
output=`sed -r 's/::.*$//g' ${SNIPS_FILE} `


[ "$kb_hint_pretty" = true ] && echo -e "$output" && exit 0

#? will display on the terminal if rofi is not found or have -j flag
if ! command -v rofi &>/dev/null; then
  echo "$output"
  echo "rofi not detected. Displaying on terminal instead"
  exit 0
fi

#? Put rofi configuration here
# Read hypr theme border
wind_border=$((hypr_border * 3 / 2))
elem_border=$([ "$hypr_border" -eq 0 ] && echo "5" || echo "$hypr_border")

# TODO Dynamic scaling for text and the window >>> I do not know if rofi is capable of this
r_width="width: ${kb_hint_width:-35em};"
r_height="height: ${kb_hint_height:-35em};"
r_listview="listview { lines: ${kb_hint_line:-13}; }"
r_override="window {$r_height $r_width border: ${hypr_width}px; border-radius: ${wind_border}px;} entry {border-radius: ${elem_border}px;} element {border-radius: ${elem_border}px;} ${r_listview} "

# Read hypr font size
fnt_override=$(gsettings get org.gnome.desktop.interface font-name | awk '{gsub(/'\''/,""); print $NF}')
fnt_override="configuration {font: \"JetBrainsMono Nerd Font ${fnt_override}\";}"

# Read hypr theme icon
icon_override=$(gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g")
icon_override="configuration {icon-theme: \"${icon_override}\";}"

#? Actions to do when selected
selected=$(echo "$output" | rofi -dmenu -p -i -theme-str "${fnt_override}" -theme-str "${r_override}" -theme-str "${icon_override}" -config "${roconf}" | sed 's/.*\s*//')

if [ -z "$selected" ]; then exit 0; fi

VALUE=`sed -n "s/^$selected:://p" $SNIPS_FILE`
printf "$VALUE" | wl-copy
printf "$VALUE" | wl-copy -p
wtype $(wl-paste)
