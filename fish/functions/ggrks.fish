function ggrks
    if count $argv > /dev/null
        for i in $argv
            set str "$str+$i"
        end
        set str (echo $str | sed 's/^\+//')
        set opt 'search?num=50&hl=ja&ie=utf-8&oe=utf-8' #&lr=lang_ja
        set opt "$opt&q=$str"
    end
    w3m http://www.google.com/$opt
end

