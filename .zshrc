# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
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
# export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light  hlissner/zsh-autopair


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# # zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::command-not-found

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

export PATH='/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/local/nvim/bin:/home/hendry/go/bin:/home/hendry/.dotnet/tools:/home/hendry/.cargo/bin:/home/hendry/.local/bin:/home/hendry/.local/share/gem/ruby/3.0.0/bin'

# Load completions
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -Uz compinit && compinit

# source <(ng completion script)
source /usr/share/nvm/init-nvm.sh
source ~/.config/zsh/zsh-vi-mode.zsh
source ~/.config/zsh/aliases.sh
source /etc/profile.d/google-cloud-cli.sh
