set nocompatible
autocmd!
if has('win32') || has('win64')
    let ostype='Win'
elseif has('mac')
    let ostype='Mac'
else
    let ostype=system('uname')
endif

if ( ostype=='Win' )
    let $PATH='D:/Program Files (x86)/Git/bin;'.$PATH
    let $PATH='D:/MinGW/msys/1.0/bin;'.$PATH
    let $PATH='D:/MinGW/bin;'.$PATH
    let $PATH=expand('$VIM/vimfiles/bin').';'.$PATH
    set runtimepath^=$HOME/.vim
    set runtimepath+=$HOME/.vim/after
endif


"---------------------------------------------------
" setting encoding and lang
if has('multi_lang')
"    language C
    language en_US.UTF-8
endif

filetype plugin off

if ostype !='Win'
    set termencoding=utf-8
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,cp932
endif

if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " check iconv supporting eucJP-ms
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
        " check iconv supporting JISX0213
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " setting fileencodings
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
"        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        if ostype != 'Win'
            let &fileencodings = s:enc_jis .','. s:enc_euc
        endif
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    " delete variable
    unlet s:enc_euc
    unlet s:enc_jis
endif
" if don't have Japanese, set fileencoding same to encoding
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" auto understanding newline character
set fileformats=unix,dos,mac
filetype plugin on

"---------------------------------------------------


"---------------------------------------------------
" setting NeoBundle
filetype off

if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle
endif 

call neobundle#begin(expand('$HOME/.vim/bundle'))
NeoBundle 'itchyny/landscape.vim', {'directory' : 'landscape'}

NeoBundle 'thinca/vim-splash'

" Must have at least
NeoBundle 'Shougo/neobundle.vim', {'directory' : 'neobundle'}
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'Shougo/unite.vim', {'directory' : 'unite'}
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'itchyny/lightline.vim', {'directory' : 'lightline'}

NeoBundle 'Shougo/vinarise'

NeoBundle 'sudo.vim', {'directory' : 'sudo'}

" tags
NeoBundle '5t111111/alt-gtags.vim', {'directory' : 'alt-gtags'}

" doc
NeoBundle 'vim-jp/vimdoc-ja'

" git
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'mattn/gist-vim'

" colorscheme
NeoBundle 'vim-scripts/Colour-Sampler-Pack'
NeoBundle 'blackgate/tropikos-vim-theme'
NeoBundle 'apribase/ap_dark8'

" all break and unite
NeoBundle 'Shougo/unite-build'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'sgur/unite-qf'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'tsukkee/unite-tag'

" disasm
NeoBundle 'shiracamus/vim-syntax-x86-objdump-d'

" tweetvim
NeoBundle 'basyura/TweetVim'
NeoBundle 'basyura/twibill.vim', {'directory' : 'twibill'}
NeoBundle 'basyura/bitly.vim', {'directory' : 'bitly'}
NeoBundle 'tyru/open-browser.vim', {'directory' : 'open-browser'}
NeoBundle 'mattn/webapi-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'yomi322/neco-tweetvim'
NeoBundle 'yomi322/unite-tweetvim'

" ime
NeoBundle 'tyru/eskk.vim', {'directory' : 'eskk'}

" reference
NeoBundle 'thinca/vim-ref'

" Haskell
NeoBundleLazy 'ujihisa/ref-hoogle', {
        \ "autoload" : { "filetypes" : [ "haskell" ] } }
NeoBundleLazy 'ujihisa/neco-ghc', {
        \ "autoload" : { "filetypes" : [ "haskell" ] } }
NeoBundleLazy 'dag/vim2hs', {
        \ "autoload" : { "filetypes" : [ "haskell" ] } }

" Pandoc
NeoBundle 'vim-pandoc/vim-pandoc'

" Rust
NeoBundle "wting/rust.vim", {'directory' : 'rust'}

" indent
NeoBundle 'nathanaelkane/vim-indent-guides'
call neobundle#end()

filetype plugin indent on
"---------------------------------------------------

"source $VIMRUNTIME/delmenu.vim
"set langmenu=none
"source $VIMRUNTIME/menu.vim

set hidden " open file ignoring modify files
set autoread

"indent, tabwidth
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
autocmd FileType text setlocal textwidth=78

" setting search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" setting edit
set backspace=indent,eol,start
set showmatch
" set autoindent
" set cindent
set autoindent
set smartindent
" set spell
set spelllang+=cjk

" setting display
set ruler
set showcmd
set number
set nowrap
set matchtime=3
set laststatus=2
set cmdheight=2
set wildmenu
syntax on

" setting backup
set backupdir=$HOME/.vim/backup
let &directory = &backupdir

" copy to clipboard
set clipboard=unnamed

colorscheme wombat256
set t_Co=256

"------------------------------------------
" disable default vim plugin of Kaoriya ver
let plugin_autodata_diable    = 1
let plugin_cmdex_disable    = 1
let plugin_dicwin_disable    = 1
let plugin_format_disable    = 1
let plugin_hz_ja_disable    = 1
let plugin_scrnmode_disable    = 1
" let plugin_verifyenc_disable    = 1
"------------------------------------------

"---------------------------------------------
" other setting
nmap ; :
:map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
:map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
nnoremap \s :set spell!<CR>

"My autocmd setting
augroup MyAutoGroup

"autocmd BufWritePost .vimrc source ~/.vimrc
"autocmd BufWritePost .gvimrc source ~/.gvimrc
"set ft=vim

" md as markdown, instead of modula2
autocmd MyAutoGroup BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set ft=markdown
augroup END

"---------------------------------------------
" setting plugin

" neocomplcache
set completeopt=menuone
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 20
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_use_vimproc = 1
if( ostype=='Linux' )
    let g:neocomplcache_temporary_dir = '/dev/shm/.neocon'
endif
let g:neocomplcache_plugin_enable = {
            \ 'syntax_complete' : 1,
            \ }

" neocomplcache-clang
let g:neocomplcache_clang_use_library = 1
let g:neocomplcache_clang_library_path = '/usr/lib/llvm'
let g:neocomplcache_max_list = 1000

" eskk.vim
set imdisable
set iminsert=0
let g:eskk#directory = "$HOME/.eskk"
let g:eskk#dictionary = { 'path' : "$HOME/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': "$HOME/.vim/dict/skk/SKK-JISYO.XXL", 'sorted': 1, 'encoding': 'euc-jp', }
let g:eskk#enable_completion = 1
let g:eskk#egg_like_newline = 1

" VimShell
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

" indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 1
let g:indent_guides_autocmds_enabled = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
if 'dark' == &background
    hi IndentGuidesOdd  ctermbg=black
    hi IndentGuidesEven ctermbg=darkgrey
else
    hi IndentGuidesOdd  ctermbg=white
    hi IndentGuidesEven ctermbg=lightgrey
endif
let g:indent_guides_enable_on_vim_startup = 1

" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [[ 'lineinfo', 'syntastic' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype']]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? '⭤' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = '⭠'
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" TweetVim
nnoremap <silent> t :Unite tweetvim<CR>
nnoremap <silent> s :TweetVimSay<CR>
nnoremap <leader>us :TweetVimUserStream<CR>
let g:tweetvim_display_source=1
let g:tweetvim_display_icon=1
let g:tweetvim_open_buffer_cmd='split'
autocmd FileType tweetvim setlocal wrap
autocmd FileType tweetvim_say setlocal wrap

