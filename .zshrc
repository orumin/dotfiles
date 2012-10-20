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
setopt correct
setopt magic_equal_subst
setopt auto_menu
setopt extended_glob
setopt list_types
setopt list_packed

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%{[31m%}completing %B%{[4;33m%}%d%b'

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

alias opera=opera-next

#alias jfbterm="env LANG=ja_JP.UTF-8 jfbterm -e uim-fep"
#alias jman="env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman"
#alias exctags=jexctags

#
# Set vi mode status bar
#

#
# Reads until the given character has been entered.
#
readuntil () {
    typeset a
    while [ "$a" != "$1" ]
    do
        read -E -k 1 a
    done
}

#
# If the $SHOWMODE variable is set, displays the vi mode, specified by
# the $VIMODE variable, under the current command line.
# 
# Arguments:
#
#   1 (optional): Beyond normal calculations, the number of additional
#   lines to move down before printing the mode.  Defaults to zero.
#
showmode() {
    typeset movedown
    typeset row

    # Get number of lines down to print mode
    movedown=$(($(echo "$RBUFFER" | wc -l) + ${1:-0}))
    
    # Get current row position
    echo -n "\e[6n"
    row="${${$(readuntil R)#*\[}%;*}"
    
    # Are we at the bottom of the terminal?
    if [ $((row+movedown)) -gt "$LINES" ]
    then
        # Scroll terminal up one line
        echo -n "\e[1S"
        
        # Move cursor up one line
        echo -n "\e[1A"
    fi
    
    # Save cursor position
    echo -n "\e[s"
    
    # Move cursor to start of line $movedown lines down
    echo -n "\e[$movedown;E"
    
    # Change font attributes
    echo -n "\e[1m"
    
    # Has a mode been set?
    if [ -n "$VIMODE" ]
    then
        # Print mode line
        echo -n "-- $VIMODE -- "
    else
        # Clear mode line
        echo -n "\e[0K"
    fi

    # Restore font
    echo -n "\e[0m"
    
    # Restore cursor position
    echo -n "\e[u"
}

clearmode() {
    VIMODE= showmode
}

#
# Temporary function to extend built-in widgets to display mode.
#
#   1: The name of the widget.
#
#   2: The mode string.
#
#   3 (optional): Beyond normal calculations, the number of additional
#   lines to move down before printing the mode.  Defaults to zero.
#
makemodal () {
    # Create new function
    eval "$1() { zle .'$1'; ${2:+VIMODE='$2'}; showmode $3 }"

    # Create new widget
    zle -N "$1"
}

# Extend widgets
makemodal vi-add-eol           INSERT
makemodal vi-add-next          INSERT
makemodal vi-change            INSERT
makemodal vi-change-eol        INSERT
makemodal vi-change-whole-line INSERT
makemodal vi-insert            INSERT
makemodal vi-insert-bol        INSERT
makemodal vi-open-line-above   INSERT
makemodal vi-substitute        INSERT
makemodal vi-open-line-below   INSERT 1
makemodal vi-replace           REPLACE
makemodal vi-cmd-mode          NORMAL

unfunction makemodal

function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&ie=utf-8&oe=utf-8&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.com/$opt
}

alias ggrks=google

is_screen_running() {
    # tscreen also uses this varariable.
    [ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
    is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
    [ ! -z "$PS1" ]
}
resolve_alias() {
    cmd="$1"
    while \
        whence "$cmd" >/dev/null 2>/dev/null \
        && [ "$(whence "$cmd")" != "$cmd" ]
    do
        cmd=$(whence "$cmd")
    done
    echo "$cmd"
}


if ! is_screen_or_tmux_running && shell_has_started_interactively; then
    for cmd in tmux tscreen screen; do
        if whence $cmd >/dev/null 2>/dev/null; then
            $(resolve_alias "$cmd") -2
            break
        fi
    done
fi

#vim:set ft=zsh:
