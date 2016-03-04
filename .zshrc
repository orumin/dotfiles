# environment variable
export PATH="$PATH:$PSPDEV/bin:$HOME/bin"
export PATH="$(ruby -rubygems -e "puts Gem.user_dir")/bin:/home/orumin/.cabal/bin:$PATH"
export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="/usr/share/git/diff-highlight:$PATH"
export PATH="/usr/lib/smlnj/bin:$PATH"
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

alias gcc='gcc -fdiagnostics-color'

alias grep='grep -n --color=auto'

#alias less='/usr/share/vim/vim74/macros/less.sh'

case `uname` in
    FreeBSD)
        alias ls='ls -G -w'
        export LSCOLORS=bxgxcadxcxegedabagacad
        ;;
    Linux)
        alias ls='ls --color'
        # set dircolors
        if [ -e ~/.dir_colors ]; then
            eval `dircolors -b ~/.dir_colors`
        else
            export LS_COLORS='no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;32:do=01;32:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;33:*.jpeg=01;33:*.gif=01;33:*.bmp=01;33:*.pbm=01;33:*.pgm=01;33:*.ppm=01;33:*.tga=01;33:*.xbm=01;33:*.xpm=01;33:*.tif=01;33:*.tiff=01;33:*.png=01;33:*.svg=01;33:*.mng=01;33:*.pcx=01;33:*.mov=01;33:*.mpg=01;33:*.mpeg=01;33:*.m2v=01;33:*.mkv=01;33:*.ogm=01;33:*.mp4=01;33:*.m4v=01;33:*.mp4v=01;33:*.vob=01;33:*.qt=01;33:*.nuv=01;33:*.wmv=01;33:*.asf=01;33:*.rm=01;33:*.rmvb=01;33:*.flc=01;33:*.avi=01;33:*.fli=01;33:*.gl=01;33:*.dl=01;33:*.xcf=01;33:*.xwd=01;33:*.yuv=01;33:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:'
        fi
        ;;
esac

alias vim='nvim'

alias la='ls -aF'
alias lf='ls -FA'
alias ll='ls -lAF'
alias lsd='ls -ld *(-/DN)' # display only Directory and DirectorySymbolicLink

#alias -g L='| less'
#alias -g H='| head'
#alias -g T='| tail'
#alias -g G='| grep'
#alias -g W='| wc'
#alias -g S='| sed'
#alias -g A='| awk'

#alias less=lv

alias unzip='unzip -Ocp932'
alias info='info --vi-keys'
alias verynice='ionice -c3 nice -n 15'
alias maxima='rlwrap maxima'
alias chkccopt="gcc -march=native -E -v - </dev/null 2>&1 | sed -n 's/.* -v - //p'"
#echo | gcc -E -v -march=native - 2>&1 | sed '/march/!d;s/.*\(-march\)/\1/'
alias pacman='sudo pacmatic'

#alias jfbterm='env LANG=ja_JP.UTF-8 jfbterm -e uim-fep'
#alias jman='env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman'
#alias exctags=jexctags

lsofcmd() { lsof -o0 -o -p $(pidof "$@") }

findgrep() { find . -name '*.c' -or -name '*.h' -exec grep -H "$@" {} \; }

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
#setopt correct # correcting spell for command
#setopt correctall # correcting spell for command argument

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
[ -f ~/zsh_plugin/zaw/zaw.zsh ] && bindkey "" zaw-history # plugin

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
[ -f ~/zsh_plugin/zaw/zaw.zsh ] && source ~/zsh_plugin/zaw/zaw.zsh

#vim:set ft=zsh:
