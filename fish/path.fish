set ostype (uname)

if test $ostype = "Darwin"
    if not contains -- "texbin" $PATH
        set -x PATH $PATH "/Library/TeX/texbin"
    end
    if not contains -- "Acrobat" $PATH
        set -x PATH $PATH "/Applications/Adobe Acrobat DC/Adobe Acrobat.app/Contents/MacOS/"
    end
    if not contains -- "Skim" $PATH
        set -x PATH $PATH "/Applications/Skim.app/Contents/MacOS/"
    end
    if not contains -- "Firefox" $PATH
        set -x PATH $PATH "/Applications/Firefox.app/Contents/MacOS/"
    end
    if not contains -- "Chrome" $PATH
        set -x PATH $PATH "/Applications/Google Chrome.app/Contents/MacOS/"
    end
    if not contains -- "Vivaldi" $PATH
        set -x PATH $PATH "/Applications/Vivaldi.app/Contents/MacOS/"
    end
    if not contains -- "VirtualBox" $PATH
        set -x PATH $PATH "/Applications/VirtualBox.app/Contents/MacOS/"
    end
    if not contains -- "Wine" $PATH
        set -x PATH $PATH "/Applications/Wine Staging.app/Contents/Resources/wine/bin/"
    end
    if not contains -- "inetutils" $PATH
        set -x PATH "/usr/local/opt/inetutils/libexec/gnubin" $PATH
        set -x MANPATH "/usr/local/opt/inetutils/libexec/gnuman" $MANPATH
    end
    if not contains -- "llvm" $PATH
        set -x PATH "/usr/local/opt/llvm/bin" $PATH
    end
end

if not contains -- "/snap/bin" $PATH
    set -x PATH /snap/bin $PATH
end
if not contains -- "$HOME/.local/bin" $PATH
    set -x PATH "$HOME/.local/bin" $PATH
end
if not contains -- "$HOME/bin" $PATH
    set -x PATH "$HOME/bin" $PATH
end

if not contains -- "$PSPDEV" $PATH
    set -x PATH $PATH "$PSPDEV/bin"
    set -x PATH $PATH "$VITASDK/bin"
end

if test $ostype != "Darwin";
    and type -q -f ruby;
    and not contains -- "ruby" $PATH
    set -x PATH (ruby -rrubygems -e "puts Gem.user_dir")/bin $PATH
end

if not contains -- "go" $PATH
    set -x PATH "/home/$USER/go/bin" $PATH
end
if not contains -- "cargo" $PATH
    set -x PATH "/home/$USER/.cargo/bin" $PATH
end
if not contains -- "cabal" $PATH
    set -x PATH "/home/$USER/.cabal/bin" $PATH
end
if not contains -- "npm-packages" $PATH
    set -x PATH "/home/$USER/.npm-packages/bin" $PATH
end
if not contains -- "ccache" $PATH
    set -x PATH "/usr/lib/ccache/bin" $PATH
end
if not contains -- "diff-highlight" $PATH
    set -x PATH "/usr/share/git/diff-highlight" $PATH
end

#set -x PATH "/usr/lib/smlnj/bin" $PATH

if echo $PATH | grep Gentoo > /dev/null
    or test (uname -r | awk -F- '{print $2}') = "gentoo"
    set -x PATH $PATH "/usr/sbin" "/sbin"
end

set -x DENO_INSTALL "/home/$USER/.deno"
set -x PATH "$DENO_INSTALL/bin" $PATH

if not contains -- "/usr/share/man" $MANPATH
    set -x MANPATH "/usr/share/man" "/usr/local/man" "/usr/local/share/man" $MANPATH
end
if not contains -- "mingw" $MANPATH
    set -x MANPATH $MANPATH "/usr/i486-mingw32/share/man"
end
if not contains -- "qt" $MANPATH
    set -x MANPATH $MANPATH "/opt/qt/man"
end
if not contains -- "/opt/pspsdk/man" $MANPATH
    set -x MANPATH $MANPATH "/opt/pspsdk/man" "/opt/pspsdk/psp/man" "/opt/pspsdk/psp/share/man"
end

if test $ostype = "Darwin"
    source ~/.rbenv_init
else if type -q -f rbenv
    source (rbenv init - | psub)
end

if test -z "$DISPLAY$WAYLAND_DISPLAY"
    if type -q carbonyl
        set -x BROWSER carbonyl
    else
        set -x BROWSER w3m
    end
else
    set -x BROWSER vivaldi
end

