#set environment variable
source $HOME/.config/fish/environment.fish
source $HOME/.config/fish/path.fish

# openSUSE on WSL1
if test (uname -r | awk -F- '{print $3}') = "Microsoft" -a $DIST_NAME = "openSUSE Leap" -a ! -d /var/run/systemd
    systemd-tmpfiles --create
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

# prompt
if type -q -f starship
    starship init fish | source
else
    source $HOME/.config/fish/git_prompt.fish
    source $HOME/.config/fish/prompt.fish
end

# completion
if type -q -f gh
    eval (gh completion -s fish)
end

set fish_greeting
set fish_emoji_width 1
set fish_amiguous_width 1

