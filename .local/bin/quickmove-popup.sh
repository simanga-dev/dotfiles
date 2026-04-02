#!/usr/bin/env sh

set -eu

result=$(
  sesh list --icons | fzf \
    --no-sort --ansi --border-label " sesh " --prompt "⚡  " \
    --header "  ^a all ^t tmux ^g git ^r configs ^x zoxide ^b worktree ^y clone ^d tmux kill ^f find" \
    --expect=ctrl-b \
    --bind "tab:down,btab:up" \
    --bind "ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)" \
    --bind "ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)" \
    --bind "ctrl-g:change-prompt(   )+reload(list-git-repos.sh)" \
    --bind "ctrl-r:change-prompt(⚙️  )+reload(sesh list -c --icons)" \
    --bind "ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)" \
    --bind "ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)" \
    --bind "ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)" \
    --bind "ctrl-y:execute($HOME/bin/clone-bare.sh)+change-prompt(⚡  )+reload(sesh list --icons)" \
    --preview-window "right:55%" \
    --preview "sesh preview {}"
  ) || exit 0

key=$(printf '%s\n' "$result" | sed -n '1p')
selected=$(printf '%s\n' "$result" | sed -n '2p')

[ -n "$selected" ] || exit 0

if [ "$key" = 'ctrl-b' ]; then
  exec "$HOME/.local/bin/open-worktree.sh" "$selected"
fi

clean=$(printf '%s' "$selected" | sed 's/\x1b\[[0-9;]*m//g' | awk '{print $2}')
clean=$(printf '%s' "$clean" | sed "s|^~|$HOME|")

exec sesh connect -c "nvim ." "$clean"
