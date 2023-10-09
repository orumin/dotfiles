set ostype (uname)

if test $ostype = "Darwin"
    set -x PATH $PATH "/Library/TeX/texbin"
    set -x PATH $PATH "/Applications/Adobe Acrobat DC/Adobe Acrobat.app/Contents/MacOS/"
    set -x PATH $PATH "/Applications/Skim.app/Contents/MacOS/"
    set -x PATH $PATH "/Applications/Firefox.app/Contents/MacOS/"
    set -x PATH $PATH "/Applications/Google Chrome.app/Contents/MacOS/"
    set -x PATH $PATH "/Applications/Vivaldi.app/Contents/MacOS/"
    set -x PATH $PATH "/Applications/VirtualBox.app/Contents/MacOS/"
    set -x PATH $PATH "/Applications/Wine Staging.app/Contents/Resources/wine/bin/"
    set -x PATH "/usr/local/opt/inetutils/libexec/gnubin" $PATH
    set -x PATH "/usr/local/opt/llvm/bin" $PATH
    set -x MANPATH "/usr/local/opt/inetutils/libexec/gnuman" $MANPATH
end

set -x PATH /snap/bin "$HOME/.local/bin" $PATH ^/dev/null

set -x PATH $PATH "$PSPDEV/bin" "$HOME/bin" ^/dev/null
set -x PATH $PATH "$VITASDK/bin" ^/dev/null

if test $ostype != "Darwin"; and type -q -f ruby
    set -x PATH (ruby -rrubygems -e "puts Gem.user_dir")/bin $PATH
end

set -x PATH "/home/$USER/go/bin" $PATH ^/dev/null
set -x PATH "/home/$USER/.cargo/bin" $PATH ^/dev/null
set -x PATH "/home/$USER/.cabal/bin" $PATH ^/dev/null
set -x PATH "/home/$USER/.rbenv/bin" $PATH ^/dev/null
set -x PATH "/usr/lib/ccache/bin" $PATH ^/dev/null
set -x PATH "/usr/share/git/diff-highlight" $PATH ^/dev/null

#set -x PATH "/usr/lib/smlnj/bin" $PATH

if echo $PATH | grep Gentoo > /dev/null
    or test (uname -r | awk -F- '{print $2}') = "gentoo"
    set -x PATH $PATH "/usr/sbin" "/sbin"
end

set -x DENO_INSTALL "/home/$USER/.deno"
set -x PATH "$DENO_INSTALL/bin" $PATH

set -x MANPATH "/usr/share/man/ja" "/usr/share/man" "/usr/local/man" "/usr/local/share/man"
set -x MANPATH $MANPATH "/usr/i486-mingw32/share/man" "/opt/qt/man"
set -x MANPATH $MANPATH "/opt/pspsdk/man" "/opt/pspsdk/psp/man" "/opt/pspsdk/psp/share/man"

if test $ostype = "Darwin"
    source ~/.rbenv_init
else if type -q -f rbenv
    source (rbenv init - | psub)
end
