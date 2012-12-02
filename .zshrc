export PATH="$PATH:$PSPDEV/bin:$HOME/bin"
export PATH="/home/orumin/.gem/ruby/1.9.1/bin:$PATH"
export PATH="/usr/lib/colorgcc/bin:$PATH"
export MANPATH="/usr/share/man/ja:/usr/share/man:/usr/local/man:/usr/local/share/man"
export MANPATH="$MANPATH:/usr/i486-mingw32/share/man:/opt/qt/man"
export MANPATH="$MANPATH:/opt/pspsdk/man:/opt/pspsdk/psp/man:/opt/pspsdk/psp/share/man"

autoload -U compinit promptinit
compinit promptinit

#prompt walters
#autoload predict-on
#predict-on

bindkey -v

setopt auto_pushd
setopt pushd_ignore_dups
setopt correct
setopt magic_equal_subst
setopt auto_menu
setopt extended_glob
setopt list_types
setopt list_packed
setopt nolistbeep

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%{[31m%}completing %B%{[4;33m%}%d%b'

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats \
    '(%{%F{white}%K{green}%}%s%{%f%k%})-[%{%F{white}%K{blue}%}%b%{%f%k%}]'
zstyle ':vcs_info:*' actionformats \
    '(%{%F{white}%K{green}%}%s%{%f%k%})-[%{%F{white}%K{blue}%}%b%{%f%k%}|%{%F{white}%K{red}%}%a%{%f%k%}]'

setopt longlistjobs
setopt nonomatch
setopt notify

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
alias lv="lv -c"
alias less=lv

alias unzip="unzip -Ocp932"
alias info="info --vi-keys"
alias maxima='rlwrap maxima'

#alias jfbterm="env LANG=ja_JP.UTF-8 jfbterm -e uim-fep"
#alias jman="env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman"
#alias exctags=jexctags


#
# Set Prompt
#  

update_prompt(){
    PROMPTTTY=`tty | sed -e 's/\/dev\///'`
    PROMPT="%b%{[32m%}%n%{[m%}@%{[32m%}%m%{[m%}<%B${PROMPTTTY}%b>
%(?..%{[44m%}%?)%{[m%}%(!.#.$) "
    RPROMPT=" %B%(?.%{[33m%}[%39<...<%~]%b%{[m%}.:()"
    SPROMPT="correct: %R -> %r ? "

    LANG=C vcs_info >&/dev/null
    if [ -n "$vcs_info_msg_0_" ]; then
        RPROMPT="${vcs_info_msg_0_}-${RPROMPT}"
    fi
}

precmd_functions=($precmd_functions update_prompt)

source ~/.zshrc.search
source ~/.zshrc.tmux
source ~/.zshrc.vimode

#vim:set ft=zsh:
