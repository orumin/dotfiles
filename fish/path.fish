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

if test $ostype != "Darwin"; and type -q -f ruby
    set -x GEM_BIN_PATH (ruby -rrubygems -e "puts Gem.user_dir")/bin

    if not contains -- "$GEM_BIN_PATH" $PATH
        set -x PATH "$GEM_BIN_PATH" $PATH
    end
end

if not contains -- "$HOME/.luarocks/bin" $PATH
    set -x PATH "$HOME/.luarocks/bin" $PATH
end
if not contains -- "$HOME/go/bin" $PATH
    set -x PATH "$HOME/go/bin" $PATH
end
if not contains -- "$HOME/.cargo/bin" $PATH
    set -x PATH "$HOME/.cargo/bin" $PATH
end
if not contains -- "$HOME/.cabal/bin" $PATH
    set -x PATH "$HOME/.cabal/bin" $PATH
end
if not contains -- "$HOME/.opam/bin" $PATH
    set -x PATH "$HOME/.opam/bin" $PATH
end
if not contains -- "$HOME/node/bin" $PATH
    set -x PATH "$HOME/node/bin" $PATH
end
if not contains -- "$HOME/node/npm-packages/bin" $PATH
    set -x PATH "$HOME/node/npm-packages/bin" $PATH
end
if not contains -- "$HOME/.nimble/bin" $PATH
    set -x PATH "$HOME/.nimble/bin" $PATH
end
if not contains -- "/usr/lib/ccache/bin" $PATH
    set -x PATH "/usr/lib/ccache/bin" $PATH
end
if not contains -- "/usr/share/git/diff-highlight" $PATH
    set -x PATH "/usr/share/git/diff-highlight" $PATH
end

#set -x PATH "/usr/lib/smlnj/bin" $PATH

if echo $PATH | grep Gentoo > /dev/null
    or test (uname -r | awk -F- '{print $2}') = "gentoo"
    set -x PATH $PATH "/usr/sbin" "/sbin"
end

set -x DENO_INSTALL "$HOME/.deno"
if not contains -- "$DENO_INSTALL/bin" $PATH
    set -x PATH "$DENO_INSTALL/bin" $PATH
end

if not contains -- "/usr/share/man" $MANPATH
    set -x MANPATH "/usr/share/man" "/usr/local/man" "/usr/local/share/man" $MANPATH
end
if not contains -- "/usr/i486-mingw32/share/man" $MANPATH
    set -x MANPATH $MANPATH "/usr/i486-mingw32/share/man"
end
if not contains -- "/opt/qt/man" $MANPATH
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

