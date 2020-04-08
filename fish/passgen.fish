function get_random_chars
    if count $argv > /dev/null
        set num $argv[1]
    else
        set num 16
    end
    set command (string trim '
        import string,random;
        print("".join(random.choices(string.ascii_letters+string.digits,k='$num')))
    ')
    python3 -c "$command"
end

function get_salted_pass
    if not count $argv > /dev/null
        echo -e "please select hash function.\nmd5, or sha256, or sha512."
        return
    end
    switch $argv[1]
        case md5
            set salt_character "\$1\$"(get_random_chars 8)
        case sha256
            set salt_character "\$5\$"(get_random_chars 16)
        case sha512
            set salt_character "\$6\$"(get_random_chars 16)
        case '*'
            echo -e "please select hash function.\nmd5, or sha256, or sha512."
            return
    end
    set command (string trim '
        import crypt,getpass;
        print(crypt.crypt(getpass.getpass(), "'$salt_character'"))
    ')
    python3 -c "$command"
end

function get_hiragana_pass
    if count $argv > /dev/null
        set num $argv[1]
    else
        set num 16
    end
    set command (string trim '
        import random;
        print("".join([ chr(0x3042+random.randint(0,82) ) for i in range(1,'$num')]))
    ')
    python3 -c "$command"
end
