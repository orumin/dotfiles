autoload -U compinit
compinit
autoload predict-on
predict-on

bindkey -v

setopt auto_pushd
setopt correct
setopt list_packed

zstyle ':completion:*' list-colors ''

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

alias h="history 25"
alias j="jobs -l"
alias ls="ls -G"
alias la="ls -aF"
alias lf="ls -FA"
alias ll="ls -lAF"

alias vi=vim
alias less=lv

