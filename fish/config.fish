#set environment variable
if test -z "$XDG_CONFIG_HOME"
    set -x XDG_CONFIG_HOME "$HOME/.config"
end
source $XDG_CONFIG_HOME/fish/environment.fish
source $XDG_CONFIG_HOME/fish/path.fish

# openSUSE on WSL1
if test (uname -r | awk -F- '{print $3}') = "Microsoft" -a $DIST_NAME = "openSUSE Leap" -a ! -d /var/run/systemd
    systemd-tmpfiles --create
end

source $XDG_CONFIG_HOME/fish/secret.fish

# utility function
source $XDG_CONFIG_HOME/fish/passgen.fish

## ls colors
#source $XDG_CONFIG_HOME/fish/lscolors.fish

# aliases
source $XDG_CONFIG_HOME/fish/alias.fish

## colors
#source $XDG_CONFIG_HOME/fish/color.fish

source $XDG_CONFIG_HOME/fish/modern_commands.fish

# prompt
if type -q -f starship
    starship init fish | source
else
    source $XDG_CONFIG_HOME/fish/git_prompt.fish
    source $XDG_CONFIG_HOME/fish/prompt.fish
end

# completion
if type -q -f gh
    eval (gh completion -s fish)
end

set fish_greeting
set fish_emoji_width 1
set fish_amiguous_width 1

