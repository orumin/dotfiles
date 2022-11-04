# Save this file to ~/.config/fish/functions/push-line.fish

# Bind the function by using this in ~/.config/fish/functions/fish_user_key_bindings.fish
# function fish_user_key_bindings
#   # For example alt+q
#   bind \eq push-line
# end

function push-line
    set -g __fish_pushed_line (commandline)
    commandline ""
    function on-next-prompt --on-event fish_prompt
        commandline $__fish_pushed_line
        functions --erase on-next-prompt
    end
end

# https://github.com/fish-shell/fish-shell/issues/6973
# https://gist.github.com/turanegaku/9ac0a75ea08dd353b5d8d0f21149666d#file-push-line-fish
