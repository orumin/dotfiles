if test -n "$XDG_CURRENT_DESKTOP"
    and test "$XDG_CURRENT_DESKTOP"="GNOME"
    alias xdg-open="gio open"
end

if type -q nvim
    alias vim='nvim'
end

set terminal_string (tty | sed -e 's|/dev/||')
if test -n (echo $terminal_string | grep pty > /dev/null)
    alias tmux='env TERM=xterm-256color tmux'
end

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

set ostype (uname)
set vendor (uname -r | awk -F- '{print $3}')
switch $ostype
    case Linux
        if test "$vendor" = "Microsoft"
            alias clipin='/mnt/c/tools/win32yank/win32yank.exe -i' 
            alias clipout='/mnt/c/tools/win32yank/win32yank.exe -o' 
        else
            alias clipin='xsel --clipboard --input'
            alias clipout='xsel --clipboard --output'
        end
    case Darwin
        alias clipin='pbcopy'
        alias clipout='pbpaste'
    end

alias chkccopt="gcc -march=native -E -v - </dev/null 2>&1 | sed -n 's/.* -v - //p'"
alias chkccdef="echo | gcc -E -xc -dM - | sort | uniq"
#echo | gcc -E -v -march=native - 2>&1 | sed '/march/!d;s/.*\(-march\)/\1/'
alias pacman='sudo pacmatic'
alias mksrcinfo='makepkg --printsrcinfo > .SRCINFO'
alias pacmanlist='/usr/bin/pacman -Qqettn'
alias aurlist='/usr/bin/pacman -Qqettm'

alias neofetch='curl -s https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch | bash'

alias tokyomx='play_tv GR 16'
alias ud='play_tv GR 28'
alias bs11='play_tv BS BS09_0'

