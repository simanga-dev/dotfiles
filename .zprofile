# start hyprland when login

export GEMINI_API_KEY="AIzaSyDi6frLW9z1WxiWBWiwKhloSA7AV1RLyww"
export OPENROUTER_API_KEY="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";
export OPENAI_API_KEY="[REDACTED:api-key]"

clipse --listen

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    wl-paste --watch cliphist store &
    exec Hyprland >/dev/null
fi
