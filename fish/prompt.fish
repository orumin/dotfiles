source $XDG_CONFIG_HOME/fish/palettes/catppuccin_mocha.fish

function echo_color --description "Echo last arg with color specified by earlier args for set_color"
    set s $argv[-1]
    set -e argv[-1]
    set_color $argv
    echo -n $s
    set_color normal
    echo
end

## Fish git prompt
#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showuntrackedfiles 'yes'
#set __fish_git_prompt_showupstream 'yes'
#set __fish_git_prompt_color_branch yellow
#set __fish_git_prompt_color_upstream_ahead green
#set __fish_git_prompt_color_upstream_behind red

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    # User
    set -l left_prompt (echo_color -b $my_color_blue -o $my_color_mantle (whoami))
    _append left_prompt (echo_color -b $my_color_surface1 -o $my_color_blue '')

    # Host
    set -l host_color $my_color_blue
    if test -n "$SSH_CONNECTION"
        set host_color $my_color_green
    end
    if echo $PATH | grep Gentoo > /dev/null
        _append left_prompt (echo_color -b $my_color_surface1 $host_color 'Gentoo on ')
    end
    _append left_prompt (echo_color -b $my_color_surface1 -o $host_color (prompt_hostname))

    # tty
    set -l prompttty (tty | sed -e 's|/dev/||')
    _append left_prompt (echo_color -b $my_color_surface1 -o $my_color_blue "  ")
    _append left_prompt (echo_color -b $my_color_surface1 -o $my_color_peach "$prompttty ")
    _append left_prompt (echo_color -b $my_color_base -o $my_color_surface1 '')

    _append left_prompt (mode_prompt $my_color_base)

    # current working dir
    _append left_prompt (echo_color -b $my_color_base -o $my_color_text (echo ' ('(echo $PWD | sed -e "s|^$HOME|~|")))

    # VCS
    set -l git (git_prompt)
    if test -n "$git"
        _append left_prompt (echo_color -b $my_color_base '|')
        _append left_prompt (echo_color -b $my_color_base -o $my_color_text $git)
        _append left_prompt (echo_color -b $my_color_base ' ')
    else
        _append left_prompt (echo_color -b $my_color_base ') ')
    end
    _append left_prompt (echo_color $my_color_base '')

    # display first line
    echo -n $left_prompt
    echo ""

    # display arrow
    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '➤ '
    set_color $fish_color_normal
end

function visual_length --description "Return visual length of string, i.e. without terminal escape sequences"
    string replace -ra '\x1b.*?[mGKH]' '' "$argv" | wc -m
end

function _append --no-scope-shadowing
    set $argv[1] "$$argv[1]""$argv[2]"
end

function mode_prompt --description "Display vi prompt mode"
    set bg_color $argv[1]
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color -b $bg_color --bold $my_color_red
                echo ' [N]'
            case insert
                set_color -b $bg_color --bold $my_color_green
                echo ' [I]'
            case replace_one
                set_color -b $bg_color --bold $my_color_green
                echo ' [R]'
            case replace
                set_color -b $bg_color --bold $my_color_cyan
                echo ' [R]'
            case visual
                set_color -b $bg_color --bold $my_color_magenta
                echo ' [V]'
        end
        set_color -b $bg_color -o $my_color_text
        echo -n ' '
    end
end

function fish_mode_prompt
end
