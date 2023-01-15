" plugin directory
let s:dein_dir = expand('$XDG_CACHE_HOME/nvim/plugins')

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
let s:toml          = expand('$XDG_CONFIG_HOME/nvim/rc/init/dein.toml')
let s:lazy_toml     = expand('$XDG_CONFIG_HOME/nvim/rc/init/dein_lazy.toml')
let s:ddc_toml     = expand('$XDG_CONFIG_HOME/nvim/rc/init/dein_ddc.toml')
let s:ddu_toml     = expand('$XDG_CONFIG_HOME/nvim/rc/init/dein_ddu.toml')

" caching TOML
if dein#load_state(s:dein_dir)
    " start configuration for dein.vim
    call dein#begin(s:dein_dir, [
          \ expand('<sfile>'), s:toml, s:lazy_toml,
          \ s:ddc_toml, s:ddu_toml,
          \ ])

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#load_toml(s:ddc_toml, {'lazy': 1})
    call dein#load_toml(s:ddu_toml, {'lazy': 0})

    " finish configuration for dein.vim
    call dein#end()

    call dein#save_state()
endif

if !has("nvim")
    syntax enable
    filetype plugin indent on
    let &t_8f = "\<Esc>[38;2;&lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;&lu;%lu;%lum"
endif

" install plugins (if it have not installed that)
if dein#check_install()
    call dein#install()
endif

