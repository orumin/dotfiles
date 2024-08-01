# Save this file to ~/.config/fish/functions/push-line.fish

# Bind the function by using this in ~/.config/fish/functions/fish_user_key_bindings.fish
# function fish_user_key_bindings
#   # For example alt+q
#   bind \eq push-line
# end

function push-line
    set -g __fish_pushed_line (commandline)
    commandline ""
    function after-next-prompt --on-event fish_postexec
        commandline $__fish_pushed_line
        functions --erase after-next-prompt
    end
end

# https://github.com/fish-shell/fish-shell/issues/6973#issuecomment-1379827312
