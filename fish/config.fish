if status is-interactive
    and not set -q TMUX
    and type -q tmux
    #        exec tmux
            tmux
end

#set environment variable
source $HOME/.config/fish/environment.fish
source $HOME/.config/fish/path.fish

# ls colors
source $HOME/.config/fish/lscolors.fish

# aliases
source $HOME/.config/fish/alias.fish

set fish_greeting

