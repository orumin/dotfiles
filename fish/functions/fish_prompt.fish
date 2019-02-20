function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    # User
    set_color $fish_color_user
    echo -n (whoami)
    set_color normal

    echo -n '@'

    # Host
    if echo $PATH | grep Gentoo > /dev/null
        set_color $fish_color_host
        echo -n 'Gentoo on '
    end
    if test -n "$SSH_CONNECTION"
        set_color -u yellow
    else
        set_color $fish_color_host
    end
    echo -n (prompt_hostname)
    set_color normal

    # tty
    set prompttty (tty | sed -e 's|/dev/||')
    echo -n "<$prompttty>"

    __terlar_git_prompt
    __fish_hg_prompt
    echo

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n '➤ '
    set_color normal
end
