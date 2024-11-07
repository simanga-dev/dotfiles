# start hyprland when login
if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    wl-paste --watch cliphist store &
    exec Hyprland >/dev/null
fi
