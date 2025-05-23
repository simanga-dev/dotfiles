# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
#
zmodload zsh/zprof
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"



# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


function expand-alias() {
	zle _expand_alias
	zle self-insert
}

zle -N expand-alias

bindkey -M main ' ' expand-alias

# This is NNN staff, please bare with mere here, I am still cooking
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='p:preview-tabbed;;:autojump;a:mtpmount;m:nmount;t:term'
export NNN_SSHFS='sshfs -o follow_symlinks'
export NNN_OPENER='nuke'
export NNN_BMS="r:$HOME/Workspace/resume"
# export NNN_BMS="r:$HOME/Workspace/resume;u:/home/user/Cam Uploads;D:$HOME/Downloads/"


# export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
#
export EDITOR=nvim
bindkey -v
export KEYTIMEOUT=1

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source ~/.config/zsh/zsh-vi-mode.zsh

# n Add in zsh plugins
#
zinit ice wait'!0'
zinit ice depth=1; zinit light romkatv/powerlevel10k
# zinit ice wait'!0'
# zinit ice depth=1; zinit light  hlissner/zsh-autopair
zinit ice wait'!0'
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'
zinit ice depth=1; zinit light zsh-users/zsh-completions
zinit ice defer'1'
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0'
zinit ice depth=1; zinit light Aloxaf/fzf-tab
export NVM_LAZY_LOAD=true
# zinit ice wait'!0'
# zinit ice depth=1; zinit load lukechilds/zsh-nvm

bindkey -v
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

bindkey '^y' autosuggest-accept
bindkey -a '^y' autosuggest-accept

bindkey '^k' autosuggest-accept
bindkey -a '^k' autosuggest-accept

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


zstyle ':completion:*' completer _expand_alias _complete _ignored
function expand-alias() {
	zle _expand_alias
	zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

# History
HISTSIZE=10000

HISTFILE=~/.zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

export PATH='/home/simanga/.config/nnn/plugins:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/local/nvim/bin:/home/simanga/go/bin:/home/simanga/.dotnet/tools:/home/simanga/.cargo/bin:/home/simanga/.local/bin:/home/simanga/.local/share/gem/ruby/3.0.0/bin'

# Load completions
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# eval "$(direnv hook zsh)"

autoload -Uz compinit && compinit

source ~/.config/zsh/aliases.sh

# pnpm
export PNPM_HOME="/home/simanga/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

## bun completions
[ -s "/home/simanga/.bun/_bun" ] && source "/home/simanga/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Load Angular CLI autocompletion.
source <(ng completion script)

# pnpm
export PNPM_HOME="/home/simanga/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
export GUI=1
