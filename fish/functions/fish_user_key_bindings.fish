function fish_user_key_bindings
    fish_vi_key_bindings
    
    for mode in insert default visual
        bind -M $mode \cp up-or-search
        bind -M $mode \cn down-or-search
    end
    
    bind -M insert \cf forward-char
    bind -M insert \ef forward-word
end
