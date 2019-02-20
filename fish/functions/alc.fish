function alc
    if count $argv > /dev/null
        w3m "http://eow.alc.co.jp/$argv/UTF-8/?ref=sa"
    else
        w3m "http://www.alc.co.jp/"
    end
end

