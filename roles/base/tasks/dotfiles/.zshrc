set -o vi

#   antigen
# ===========
source ~/.antigen.zsh

# Plugins
antigen bundle jocelynmallon/zshmarks
alias g="jump"
alias s="bookmark"
alias d="deletemark"
alias p="showmarks"
alias l="showmarks"

antigen bundle zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
# ===========

alias vi="nvim"
alias vim="nvim"
alias cl="clear"
alias im="imgcat"
alias ls="ls -GF"
alias ll="ls -lGF"
alias lh="ls -lhGF"
alias la="ls -aGF"
alias lla="ls -alGF"
alias pipup="pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"


export PATH="$HOME/.scripts/":$PATH
export PATH="/usr/local/sbin:$PATH"
export LANG="en_US.UTF-8"
export EDITOR="nvim"

bindkey -a j vi-down-line-or-history
bindkey -a k vi-up-line-or-history

eval "$(starship init zsh)"

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=20000

bindkey '^N' autosuggest-accept
