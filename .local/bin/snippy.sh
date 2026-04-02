#!/usr/bin/env sh

# shellcheck disable=SC1090
if ! source "$(command -v hyde-shell)"; then
    echo "[wallbash] code :: Error: hyde-shell not found."
    echo "[wallbash] code :: Is HyDE installed?"
    exit 1
fi

# define paths and files
cache_dir="${HYDE_CACHE_HOME:-$HOME/.cache/hyde}"
favorites_file="${cache_dir}/landing/cliphist_favorites"
[ -f "$HOME/.cliphist_favorites" ] && favorites_file="$HOME/.cliphist_favorites"
cliphist_style="${ROFI_CLIPHIST_STYLE:-clipboard}"
del_mode=false



# execute rofi with common parameters
run_rofi() {
    local placeholder="$1"
    shift

    rofi -dmenu \
        -theme-str "entry { placeholder: \"${placeholder}\";}" \
        -theme-str "${font_override}" \
        -theme-str "${r_override}" \
        -theme-str "${rofi_position}" \
        -theme "${cliphist_style}" \
        "$@"
}

# setup rofi configuration
setup_rofi_config() {
    # font scale
    local font_scale="${ROFI_CLIPHIST_SCALE}"
    [[ "${font_scale}" =~ ^[0-9]+$ ]] || font_scale=${ROFI_SCALE:-10}

    # set font name
    local font_name=${ROFI_CLIPHIST_FONT:-$ROFI_FONT}
    font_name=${font_name:-$(get_hyprConf "MENU_FONT")}
    font_name=${font_name:-$(get_hyprConf "FONT")}

    # set rofi font override
    font_override="* {font: \"${font_name:-"JetBrainsMono Nerd Font"} ${font_scale}\";}"

    # border settings
    local hypr_border=${hypr_border:-"$(hyprctl -j getoption decoration:rounding | jq '.int')"}
    local wind_border=$((hypr_border * 3 / 2))
    local elem_border=$((hypr_border == 0 ? 5 : hypr_border))

    # rofi position
    rofi_position="configuration { location: 0; anchor: 50%; fixed-location: true; }"

    # border width
    local hypr_width=${hypr_width:-"$(hyprctl -j getoption general:border_size | jq '.int')"}
    r_override="window{border:${hypr_width}px;border-radius:${wind_border}px;}wallbox{border-radius:${elem_border}px;} element{border-radius:${elem_border}px;}"
}



setup_rofi_config

SNIPS_FILE="${HOME}/Workspace/my-notes/snippets/snippets.txt"
output=$(sed -r 's/::.*$//g' "${SNIPS_FILE}")


selected=$(echo "$output" | run_rofi "🔎 Choose Snippy")

# exit if nothing is selected
if [ -z "$selected" ]; then
    exit 0
fi

VALUE=$(sed -n "s/^${selected}:://p" "${SNIPS_FILE}")

# if a value is found, copy it and type it
if [ -n "${VALUE}" ]; then
    printf "%s" "${VALUE}" | wl-copy
    printf "%s" "${VALUE}" | wl-copy -p

    hyprctl dispatch sendshortcut "CTRL SHIFT,V,"
fi




# #!/usr/bin/env sh
#
# if ! tmux has-session -t special 2>/dev/null; then
#   tmux new-session -d -s special
# fi
#
# if ! hyprctl clients 2>/dev/null | grep -q "NIDE"; then
# 	alacritty -T "neovim" --class "NIDE" -e tmux attach-session -t special &
# 	while ! hyprctl clients 2>/dev/null | grep -q "NIDE"; do
# 		sleep 0.1
# 	done
# fi
#
# if ! hyprctl activewindow 2>/dev/null | grep -q "special:special"; then
# 	hyprctl dispatch togglespecialworkspace special
# fi
#
# tmux display-popup -E "snippy-snipy.sh"
#
