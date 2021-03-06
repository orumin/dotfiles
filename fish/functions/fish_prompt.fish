## Fish git prompt
#set __fish_git_prompt_showdirtystate 'yes'
#set __fish_git_prompt_showstashstate 'yes'
#set __fish_git_prompt_showuntrackedfiles 'yes'
#set __fish_git_prompt_showupstream 'yes'
#set __fish_git_prompt_color_branch yellow
#set __fish_git_prompt_color_upstream_ahead green
#set __fish_git_prompt_color_upstream_behind red
#
## Status Chars
#set __fish_git_prompt_char_dirtystate '⚡'
#set __fish_git_prompt_char_stagedstate '→'
#set __fish_git_prompt_char_untrackedfiles '☡'
#set __fish_git_prompt_char_stashstate '↩'
#set __fish_git_prompt_char_upstream_ahead '+'
#set __fish_git_prompt_char_upstream_behind '-'

function fish_prompt --description 'Write out the prompt'
	set -l last_status $status
    set -l bg_color black
    set -l fg_color white

    # User
    set -l left_prompt (echo_color -b $bg_color -o $fish_color_user (whoami))

    _append left_prompt (echo_color -b $bg_color $fg_color '@')

    # Host
    if echo $PATH | grep Gentoo > /dev/null
        _append left_prompt (echo_color -b $bg_color $fish_color_host 'Gentoo on ')
    end
    if set -q SSH_TTY
        set -g fish_color_host \x2du yellow
    end
    _append left_prompt (echo_color -b $bg_color -o $prompt_tty_opt $fish_color_host (prompt_hostname))

    # tty
    set -l prompttty (tty | sed -e 's|/dev/||')
    _append left_prompt (echo_color -b $bg_color $fg_color "<$prompttty>")

    # VCS
    set -l git (__fish_git_prompt)
    if test -n "$git"
        _append left_prompt (echo_color -b $bg_color "$git")
    end
    set -l hg (__fish_hg_prompt)
    if test -n "$hg"
        _append left_prompt (echo_color -b $bg_color "$hg")
    end

    # right prompt
    set -l right_prompt (fish_default_mode_prompt)
#    _append right_prompt (echo_color -b $bg_color -o $fish_color_cwd (echo '['(prompt_pwd)']'))
    _append right_prompt (echo_color -b $bg_color -o $fish_color_cwd (echo '['(echo $PWD | sed -e "s|^$HOME|~|")']'))

    # calc spaces
    set -l left_length (visual_length $left_prompt)
    set -l right_length (visual_length $right_prompt)
    set -l spaces (math "$COLUMNS - $left_length - $right_length")

    # display first line
    echo -n $left_prompt
    set_color -b $bg_color
    printf "%-"$spaces"s" " "
    echo $right_prompt

    # display arrow
    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '➤ '
    set_color normal
end

function visual_length --description "Return visual length of string, i.e. without terminal escape sequences"
    # TODO: Use "string replace" builtin in Fish 2.3.0
    printf $argv | perl -pe 's/\x1b.*?[mGKH]//g' | wc -m
end

function echo_color --description "Echo last arg with color specified by earlier args for set_color"
    set s $argv[-1]
    set -e argv[-1]
    set_color $argv
    echo -n $s
    set_color normal
    echo
end

function _append --no-scope-shadowing
    set $argv[1] "$$argv[1]""$argv[2]"
end

