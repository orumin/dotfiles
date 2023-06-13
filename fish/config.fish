#set environment variable
source $HOME/.config/fish/environment.fish
if test -z $TMUX
    source $HOME/.config/fish/path.fish

    # openSUSE on WSL1
    if test (uname -r | awk -F- '{print $3}') = "Microsoft" -a $DIST_NAME = "openSUSE Leap" -a ! -d /var/run/systemd
        systemd-tmpfiles --create
    end
end

source $HOME/.config/fish/secret.fish

# utility function
source $HOME/.config/fish/passgen.fish

## ls colors
#source $HOME/.config/fish/lscolors.fish

# aliases
source $HOME/.config/fish/alias.fish

## colors
#source $HOME/.config/fish/color.fish

# completion
if type -q -f gh
    eval (gh completion -s fish)
end

set fish_greeting
set fish_emoji_width 2
set fish_amiguous_width 2

if status is-interactive
    and not set -q TMUX
    and type -q tmux
    set -x COLORTERM "$COLORTERM"
    set -x SSH_CONNECTION "$SSH_CONNECTION"
#    exec tmux
    tmux
end
