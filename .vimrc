set nocompatible
set tags=~/.tags

set encoding=utf-8
set ambw=double
set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
let $LANG='ja_JP.UTF-8'
set nowrap
set number
set modifiable
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoindent
colorscheme desert

syntax on
set hlsearch

filetype plugin indent on
augroup vimrcEx
 au!

autocmd FileType text setlocal textwidth=78

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2


" Setting for NeoBundle
filetype plugin indent off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/vinarise.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/basyura/twibill.vim.git'
NeoBundle 'git://github.com/basyura/webapi-vim.git'
NeoBundle 'git://github.com/basyura/bitly.vim.git'
NeoBundle 'git://github.com/basyura/TweetVim.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'
NeoBundle 'git://github.com/yuratomo/w3m.vim.git'

filetype plugin indent on


"neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化

"w3m.vim
let g:w3m#command = "/usr/bin/w3m"
