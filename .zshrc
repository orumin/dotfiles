# environment variable
case `uname` in
    Darwin)
        export PATH="$PATH:/Library/TeX/texbin"
        ;;
esac
export PATH="$PATH:$PSPDEV/bin:$HOME/bin"
export PATH="$PATH:$VITASDK/bin"
which ruby > /dev/null 2>&1  && export PATH="$(ruby -rrubygems -e "puts Gem.user_dir")/bin:$PATH"
export PATH="/home/orumin/.cabal/bin:$PATH"
export PATH="/usr/lib/ccache/bin:$PATH"
export PATH="/usr/share/git/diff-highlight:$PATH"
#export PATH="$HOME/.cargo/bin:$PATH"
#export PATH="/usr/lib/smlnj/bin:$PATH"
if [ -n "$(echo $PATH | grep Gentoo)" ]; then
    export PATH="$PATH:/sbin"
fi
export MANPATH="/usr/share/man/ja:/usr/share/man:/usr/local/man:/usr/local/share/man"
export MANPATH="$MANPATH:/usr/i486-mingw32/share/man:/opt/qt/man"
export MANPATH="$MANPATH:/opt/pspsdk/man:/opt/pspsdk/psp/man:/opt/pspsdk/psp/share/man"

which rbenv > /dev/null 2>&1 && eval "$(rbenv init -)"

# other environment variable
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
REPORTTIME=3

# set default permission file -> 644 directory -> 755
umask 022

[ ! -d $HOME/.zfunc ] && mkdir $HOME/.zfunc
[ ! -f $HOME/.zfunc/_rustup ] && [ -f /usr/bin/rustup ] && rustup completions zsh > $HOME/.zfunc/_rustup

fpath+=$HOME/.zfunc

[ -f ~/.zshrc.color ] && source ~/.zshrc.color

# most necesary setting
autoload -U compinit promptinit 
compinit promptinit 


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
zstyle ':completion:*' format "%B${fg_red}completing %B${underline}${fg_yellow}%d%b"

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

GCC_VERSION=$(gcc -dumpversion | awk -F. '{printf "%2d%02d%02d", $1,$2,$3}')

alias grep='grep --color=auto'

#alias less='/usr/share/vim/vim74/macros/less.sh'

case `uname` in
    Darwin)
        if [ -z $(which ls | grep Gentoo) ]; then
            alias ls='ls -G -w'
            export LSCOLORS=fxgxcxdxcxegedabagacad
        else
            alias ls='ls --color'
            # set dircolors
            if [ -e ~/.dir_colors ]; then
                eval `dircolors -b ~/.dir_colors`
            else
                export LS_COLORS='no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;32:do=01;32:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;33:*.jpeg=01;33:*.gif=01;33:*.bmp=01;33:*.pbm=01;33:*.pgm=01;33:*.ppm=01;33:*.tga=01;33:*.xbm=01;33:*.xpm=01;33:*.tif=01;33:*.tiff=01;33:*.png=01;33:*.svg=01;33:*.mng=01;33:*.pcx=01;33:*.mov=01;33:*.mpg=01;33:*.mpeg=01;33:*.m2v=01;33:*.mkv=01;33:*.ogm=01;33:*.mp4=01;33:*.m4v=01;33:*.mp4v=01;33:*.vob=01;33:*.qt=01;33:*.nuv=01;33:*.wmv=01;33:*.asf=01;33:*.rm=01;33:*.rmvb=01;33:*.flc=01;33:*.avi=01;33:*.fli=01;33:*.gl=01;33:*.dl=01;33:*.xcf=01;33:*.xwd=01;33:*.yuv=01;33:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:'
            fi
        fi
        ;;
    FreeBSD)
        if [ "$GCC_VERSION" -ge 40900 ]; then
            alias gcc='gcc -fdiagnostics-color'
        fi
        alias ls='ls -G -w'
        export LSCOLORS=fxgxcxdxcxegedabagacad
        ;;
    Linux)
        if [ "$GCC_VERSION" -ge 40900 ]; then
            alias gcc='gcc -fdiagnostics-color'
        fi
        alias ls='ls --color'
        # set dircolors
        if [ -e ~/.dir_colors ]; then
            eval `dircolors -b ~/.dir_colors`
        else
            export LS_COLORS='no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;32:do=01;32:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;33:*.jpeg=01;33:*.gif=01;33:*.bmp=01;33:*.pbm=01;33:*.pgm=01;33:*.ppm=01;33:*.tga=01;33:*.xbm=01;33:*.xpm=01;33:*.tif=01;33:*.tiff=01;33:*.png=01;33:*.svg=01;33:*.mng=01;33:*.pcx=01;33:*.mov=01;33:*.mpg=01;33:*.mpeg=01;33:*.m2v=01;33:*.mkv=01;33:*.ogm=01;33:*.mp4=01;33:*.m4v=01;33:*.mp4v=01;33:*.vob=01;33:*.qt=01;33:*.nuv=01;33:*.wmv=01;33:*.asf=01;33:*.rm=01;33:*.rmvb=01;33:*.flc=01;33:*.avi=01;33:*.fli=01;33:*.gl=01;33:*.dl=01;33:*.xcf=01;33:*.xwd=01;33:*.yuv=01;33:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:'
        fi
        ;;
esac

if [ -n "$XDG_CURRENT_DESKTOP" ] && [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    alias xdg-open='gio open'
fi

[ -f /usr/bin/nvim ] && alias vim='nvim'
alias tmux='env TERM=xterm-256color tmux'

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
alias luajitlatex='luajittex --fmt=luajitlatex.fmt'
alias clipin='xsel --clipboard --input'
alias clipout='xsel --clipboard --output'
alias chkccopt="gcc -march=native -E -v - </dev/null 2>&1 | sed -n 's/.* -v - //p'"
alias chkccdef="echo | gcc -E -xc -dM - | sort | uniq"
#echo | gcc -E -v -march=native - 2>&1 | sed '/march/!d;s/.*\(-march\)/\1/'
alias pacman='sudo pacmatic'
alias mksrcinfo='makepkg --printsrcinfo > .SRCINFO'
alias pacmanlist='/usr/bin/pacman -Qqettn'
alias aurlist='/usr/bin/pacman -Qqettm'

#alias jfbterm='env LANG=ja_JP.UTF-8 jfbterm -e uim-fep'
#alias jman='env LANG=ja_JP.eucJP GROFF_NO_SGR=true jman'
#alias exctags=jexctags

lsofcmd() { lsof -o0 -o -p $(pidof "$@") }

findgrep() { find . -name '*.c' -or -name '*.h' -exec grep -H "$@" {} \; }

play_tv() { mpv "http://mani:40772/api/channels/$1/$2/stream?decode=1" }

alias tokyomx='play_tv GR 16'
alias ud='play_tv GR 28'
alias bs11='play_tv BS BS09_0'

# history
#
setopt hist_ignore_dups # no recoding duplicate command
setopt hist_save_no_dups # no recoding duplicate command in history
setopt share_history # sharing history between other session in real time
setopt hist_reduce_blanks # recoding history its removed extra space
setopt incappend_history # recoding history in order on multiple session
setopt histnostore # no recoding history command in history
setopt inc_append_history # add history as increment
setopt extended_history # add execute date to history

# fileglob
#
setopt extendedglob # use extended glob
setopt globdots # match dotfiles
setopt magic_equal_subst # glob after = (ex. ./configure --prefix=...)
#setopt numericglobsort # sorted by numeric

# I/O
#
#setopt noclobber # show error for overwrite redirect
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
    if [ -n "$(echo $PATH | grep Gentoo)" ]; then
        gentoo_prompt="${fg_default}Gentoo on "
    fi
    if [ -n "$SSH_CONNECTION" ]; then
        prompt_hostname="${fg_yellow}${underline}%m${clear}"
    else
        prompt_hostname="${fg_green}%m${fg_default}"
    fi
    PROMPT="%b${fg_green}%n${fg_default}@${gentoo_prompt}${prompt_hostname}<%B${PROMPTTTY}%b>
%(?..${bg_blue}%?)${clear}%(!.#.$) "
    RPROMPT=" %B%(?.${fg_yellow}[%39<...<%~]%b${fg_default}.:()"
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
# PDF producing from markdown using pandoc w/ Japanese
#

md2pdf() {
    if [ $# -ne 5 ]; then
        echo "Usage: $0 <title> <author> <date> <input file> <output file>"
        return 1
    fi

    case `uname` in
        Linux)
#            fontfamily=sourcehan-jp,deluxe
            fontfamily=hiragino-pron,deluxe,jis2004
        ;;
        Darwin)
            fontfamily=hiragino-pron,deluxe,jis2004
        ;;
    esac

(cat << EOF
---
title: $1
author: $2
date: $3
header-includes:
    - \usepackage{unicode-math}
    - \unimathsetup{math-style=ISO,bold-style=ISO}
    - \setmathfont{TeX Gyre Pagella Math}
    - \setmainfont[Ligatures=TeX, Scale=0.95]{TeX Gyre Pagella}
    - \setsansfont[Ligatures=TeX, Scale=0.95]{TeX Gyre Heros}
    - \setmonofont[Ligatures=TeX, Scale=1]{TeX Gyre Cursor}
    - \renewcommand{\bfdefault}{bx}
    - \renewcommand{\headfont}{\gtfamily\sffamily\bfseries}
    - \usepackage{luacode}
    - \usepackage{luatexja-otf}
    - \usepackage[$fontfamily]{luatexja-preset}
    - \ltjsetparameter{jacharrange={-2}}
    - \usepackage[euler-digits,euler-hat-accent]{eulervm}

---
EOF
)   | cat - $4 \
    | pandoc -f markdown -t latex \
        --latex-engine=lualatex \
        -V documentclass=ltjsarticle \
        -V classoption=10.5ptj -V classoption=a4paper \
        -o $5
}

#
# appendix
#

fizzbuzz() {
    seq $1 | sed '5~5s/.*/Buzz/' | sed '3~3s/[0-9]*/Fizz/'
}

prime() {
    seq 2 $1 | factor | awk '$0*=!$3'
}

#
# setting city by geoiplookup
#

if [ "ping not found" = "$(which ping)" ]; then
    if [ "ping4 not found" != "$(which ping4)" ]; then PING=ping4;
    else export CITY=Tokyo
    fi
elif [ "Darwin" = "$(uname)" ]; then PING=ping;
elif [ -z "$(ping 2>&1 | grep 'ping -6')" ]; then PING=ping;
else PING=ping && PING_OPT=-4
fi

if [ -z "$CITY" ]; then
    $PING $PING_OPT google.com -c 1 -W 3 >> /dev/null
    if [ $? -eq 0 ] && [ -e /usr/bin/geoiplookup ] && [ -e /usr/bin/dig ]; then
#        export CITY=$(echo $(geoiplookup $(curl -s4 inet-ip.info) | grep City | awk -F , '{print $4}'))
#        export CITY=$( curl -s4 ipinfo.io | grep city | cut -d: -f 3 | sed -e 's/ *"\(.*\)",/\1/' )
        PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
        if [ -z "$PUBLIC_IP" ]; then
            export CITY=$( curl -s4 ipinfo.io | grep city | cut -d: -f 3 | sed -e 's/ *"\(.*\)",/\1/' )
        else
            export CITY=$(echo $(geoiplookup $(dig +short myip.opendns.com @resolver1.opendns.com) | grep City | awk -F , '{print $4}'))
        fi
        if [ "$CITY" = "N/A" ] || [ "$CITY" = "" ] ; then
            export CITY=Tokyo
        fi
    else
        export CITY=Tokyo
    fi
fi

#
# Include other files
#

[ -f ~/.zshrc.utils ] && source ~/.zshrc.utils
[ -f ~/.zshrc.search ] && source ~/.zshrc.search
[ -f ~/.zshrc.tmux ] && source ~/.zshrc.tmux
[ -f ~/.zshrc.vimode ] && source ~/.zshrc.vimode
[ -f ~/alias-sradio.txt ] && source ~/alias-sradio.txt
[ -f ~/zsh_plugin/zaw/zaw.zsh ] && source ~/zsh_plugin/zaw/zaw.zsh

#vim:set ft=zsh:
