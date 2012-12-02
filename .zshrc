# environment variable
export PATH="$PATH:$PSPDEV/bin:$HOME/bin"
export PATH="/home/orumin/.gem/ruby/1.9.1/bin:$PATH"
export PATH="/usr/lib/colorgcc/bin:$PATH"
export MANPATH="/usr/share/man/ja:/usr/share/man:/usr/local/man:/usr/local/share/man"
export MANPATH="$MANPATH:/usr/i486-mingw32/share/man:/opt/qt/man"
export MANPATH="$MANPATH:/opt/pspsdk/man:/opt/pspsdk/psp/man:/opt/pspsdk/psp/share/man"

# other environment variable
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# set default permision file -> 644 directory -> 755
umask 022

# most necesary setting
autoload -U compinit promptinit
compinit promptinit

autoload colors
colors

## prompt preset
#prompt walters

## progronosisi complete
##
#autoload predict-on
#predict-on

# set keybind like vi
bindkey -v

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

alias vi=vim
alias lv='lv -c'
alias less=lv

alias unzip='unzip -Ocp932'
alias info='info --vi-keys'
alias maxima='rlwrap maxima'

#alias jfbterm='env LANG=ja_JP.UTF-8 jfbterm -e uim-fep'
#alias jman='env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman'
#alias exctags=jexctags

# history
#
setopt hist_ignore_dups # no recoding duplicate command
setopt share_history # sharing history between other session in real time
setopt hist_reduce_blanks # recoding history its removed extra space
setopt incappend_history # recoding history in order on multiple session
setopt histnostore # no recoding history command in history

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
# complete from command history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

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

## terminal color
## http://news.mynavi.jp/column/zsh/024/
#case "${TERM}" in
#screen)
#    TERM=xterm
#    ;;
#esac
#
#case "${TERM}" in
#xterm|xterm-color)
#    export LSCOLORS=exfxcxdxbxegedabagacad
#    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#    ;;
#kterm-color)
#    stty erase '^H'
#    export LSCOLORS=exfxcxdxbxegedabagacad
#    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#    ;;
#kterm)
#    stty erase '^H'
#    ;;
#cons25)
#    unset LANG
#    export LSCOLORS=ExFxCxdxBxegedabagacad
#    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
#    ;;
#jfbterm-color)
#    export LSCOLORS=gxFxCxdxBxegedabagacad
#    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
#    ;;
#esac

#
# Include other files
#

[ -f ~/.zshrc.search ] && source ~/.zshrc.search
[ -f ~/.zshrc.tmux ] && source ~/.zshrc.tmux
[ -f ~/.zshrc.vimode ] && source ~/.zshrc.vimode

#vim:set ft=zsh:
