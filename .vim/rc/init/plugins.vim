" plugin directory
let s:dein_dir = expand('~/.vim/bundle')

" dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" download dein.vim if it's not installed
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" TOML File for plugin list
let s:toml          = expand('~/.vim/rc/init/dein.toml')
let s:lazy_toml     = expand('~/.vim/rc/init/dein_lazy.toml')

" caching TOML
if dein#load_state(s:dein_dir)
    " start configuration for dein.vim
    call dein#begin(s:dein_dir)

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    " finish configuration for dein.vim
    call dein#end()

    call dein#save_state()
endif

" install plugins (if it have not installed that)
if dein#check_install()
    call dein#install()
endif

