export PATH="$PATH:$PSPDEV/bin:$HOME/bin"
export PATH="/home/orumin/.gem/ruby/1.9.1/bin:$PATH"
export PATH="/usr/lib/colorgcc/bin:$PATH"

autoload -U compinit
compinit

#prompt walters
#autoload predict-on
#predict-on

bindkey -v

setopt auto_pushd
setopt correct
setopt magic_equal_subst
setopt auto_menu
setopt extended_glob
setopt list_types
setopt list_packed


zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

setopt complete_aliases
alias h="history 25"
alias j="jobs -l"
alias ls="ls --color=auto"
alias la="ls -aF"
alias lf="ls -FA"
alias ll="ls -lAF"

alias vi=vim
alias less=lv

alias ttytter="ttytter -ansi"

alias unzip="unzip -Ocp932"

#alias jfbterm="env LANG=ja_JP.UTF-8 jfbterm -e uim-fep"
#alias jman="env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman"
#alias exctags=jexctags

#vim:set ft=zsh:
