function git --wraps git
    set real_git (which git)
    if test "$argv[1]" = "difft"
        env GIT_EXTERNAL_DIFF=difft $real_git diff $argv[2..-1]
    else
        $real_git $argv[1..-1]
    end
end
