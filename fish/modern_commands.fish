function replace_posix
    set real_command (which $argv[1])
    set modern_command $argv[2]
    if type -q $modern_command
        if test "$argv[4]" = "classic"
            $real_command $argv[5..-1]
        else
            if test "$argv[3]" != ''
                $modern_command $argv[3..-1]
            else
                $modern_command $argv[4..-1]
            end
        end
    else
        $real_command $argv[4..-1]
    end
end

function ls --wraps ls
    replace_posix ls exa --icons $argv
end

function cat --wraps cat
    replace_posix cat bat '' $argv
end

function find --wraps find
    replace_posix find fd '' $argv
end

function grep --wraps grep
    replace_posix grep rg '' $argv
end

function ps --wraps ps
    replace_posix ps procs '' $argv
end
