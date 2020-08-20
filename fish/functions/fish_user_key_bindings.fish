function fish_user_key_bindings
    fish_vi_key_bindings
    
    set FISH_VERSTRING (echo "$FISH_VERSION" | tr -d '.')
    for mode in insert default visual
        if test $FISH_VERSTRING -ge 310
            bind -M $mode \cp history-prefix-search-backward
            bind -M $mode \cn history-prefix-search-forward
        else
            bind -M $mode \cp up-or-search
            bind -M $mode \cn down-or-search
        end
    end
    
    bind -M insert \cb backward-char
    bind -M insert \cf forward-char
    bind -M insert \ef forward-word

    bind -M insert \cq push-line
    bind -M default \cq push-line
end
