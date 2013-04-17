# environment variable
export PATH="$PATH:$PSPDEV/bin:$HOME/bin"
export PATH="/home/orumin/.gem/ruby/2.0.0/bin:$PATH"
export PATH="/usr/lib/colorgcc/bin:$PATH"
export MANPATH="/usr/share/man/ja:/usr/share/man:/usr/local/man:/usr/local/share/man"
export MANPATH="$MANPATH:/usr/i486-mingw32/share/man:/opt/qt/man"
export MANPATH="$MANPATH:/opt/pspsdk/man:/opt/pspsdk/psp/man:/opt/pspsdk/psp/share/man"

# other environment variable
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
REPORTTIME=3

# set default permission file -> 644 directory -> 755
umask 022

# set dircolors
eval `dircolors ~/.dir_colors`

# most necesary setting
autoload -U compinit promptinit colors
compinit promptinit colors


## prompt preset
#prompt walters

## progronosisi complete
##
#autoload predict-on
#predict-on

# set keybind like vi
bindkey -v
# bindkey hjkl to select complete menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# grouping complete command
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%{[31m%}completing %B%{[4;33m%}%d%b'

# display vcs infomation
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats \
    '(%{%F{white}%K{green}%}%s%{%f%k%})-[%{%F{white}%K{blue}%}%b%{%f%k%}]'
zstyle ':vcs_info:*' actionformats \
    '(%{%F{white}%K{green}%}%s%{%f%k%})-[%{%F{white}%K{blue}%}%b%{%f%k%}|%{%F{white}%K{red}%}%a%{%f%k%}]'

# alias
setopt complete_aliases
alias h='history 25'
alias j='jobs -l'

case `uname` in
    FreeBSD)
        alias ls='ls -G -w'
        ;;
    Linux)
        alias ls='ls --color'
        ;;
esac

alias la='ls -aF'
alias lf='ls -FA'
alias ll='ls -lAF'
alias lsd='ls -ld *(-/DN)' # display only Directory and DirectorySymbolicLink

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'

GREP_OPTIONS="--color=auto $GREP_OPTIONS"

alias less=lv

alias unzip='unzip -Ocp932'
alias info='info --vi-keys'
alias maxima='rlwrap maxima'
alias pacman='pacmatic'

#alias jfbterm='env LANG=ja_JP.UTF-8 jfbterm -e uim-fep'
#alias jman='env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman'
#alias exctags=jexctags

# history
#
setopt hist_ignore_dups # no recoding duplicate command
setopt hist_save_no_dups # no recoding duplicate command in history
setopt share_history # sharing history between other session in real time
setopt hist_reduce_blanks # recoding history its removed extra space
setopt incappend_history # recoding history in order on multiple session
setopt histnostore # no recoding history command in history
setopt inc_append_history # add history as increment
setopt EXTENDED_HISTORY

# fileglob
#
setopt extendedglob # use extended glob
setopt globdots # match dotfiles
setopt magic_equal_subst # glob after = (ex. ./configure --prefix=...)
#setopt numericglobsort # sorted by numeric

# I/O
#
setopt noclobber # show error for overwrite redirect
setopt correct # correcting spell for command
setopt correctall # correcting spell for command argument

# changing directory
#
setopt cdable_vars # assignment absolute path variable regard to directory
setopt auto_cd # moving directory only typing directory name
setopt auto_pushd # push directory stack only cd command
setopt pushd_ignore_dups # no pushing duplicate directory 

# control job
#
setopt autoresume # resume job type job's initial
setopt longlistjobs # use long formant for job list
setopt notify # quick display background job status

# complete
#
#setopt autolist # it has complete candidate, auto listup menu
#setopt auto_menu
setopt list_types # display file type when compliting
setopt list_packed # packed disoplay when compliting
setopt nolistbeep # mute beep
setopt completeinword
# complete from command history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end
#bindkey "^h" zaw-history #qiita.com/item/c1a1567b2b76051f50c4

# bindkey
#
setopt noflowcontrol # to use C-q, C-s
bindkey '' push-line-or-edit # to use buffer stack on vi keybind

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


#
# Colored man page
#
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
                    man "$@"
}

#
# show all history
#
history-all() { history -E 1 }

#
# Include other files
#

[ -f ~/.zshrc.search ] && source ~/.zshrc.search
[ -f ~/.zshrc.tmux ] && source ~/.zshrc.tmux
[ -f ~/.zshrc.vimode ] && source ~/.zshrc.vimode
[ -f ~/alias-sradio.txt ] && source ~/alias-sradio.txt

#vim:set ft=zsh:
