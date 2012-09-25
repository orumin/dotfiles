export PSPDEV="/opt/pspsdk"
export PATH="$PATH:$PSPDEV/bin:$HOME/bin"

autoload -U compinit
compinit
#autoload predict-on
#predict-on

bindkey -v

setopt auto_pushd
setopt correct
setopt list_packed

setopt complete_aliases

zstyle ':completion:*' list-colors ''

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

alias h="history 25"
alias j="jobs -l"
alias ls="ls --color=auto"
alias la="ls -aF"
alias lf="ls -FA"
alias ll="ls -lAF"

alias vi=vim
alias less=lv

alias pacman=pacman-color
alias ttytter="ttytter -ansi"

alias unzip="unzip -Ocp932"

#alias jfbterm="env LANG=ja_JP.UTF-8 jfbterm -e uim-fep"
#alias jman="env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman"
#alias exctags=jexctags
