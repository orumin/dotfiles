set hidden " open file ignoring modify files
set autoread " reload file if file is editted by external system

" indent, tabwidth
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
autocmd FileType text setlocal textwidth=78

" setting search
set hlsearch " hilighting
set incsearch " increment search
set ignorecase " no differentiate char case
set smartcase " differentiate char case if search by mixed case word
set wrapscan

" setting edit
set backspace=indent,eol,start
set showmatch
set smartindent
"set iminsert=2 " disable IME when escape from insert mode
" set spell
set spelllang=en_us,cjk

" setting display
set ruler
set showcmd
set number
set nowrap
set list " display invisible character
set listchars=tab:▸\ ,space:⋅,eol:↲,extends:❯,precedes:❮
set matchtime=3
set laststatus=2
set cmdheight=2
set wildmenu
" https://github.com/neovim/neovim/issues/6041
set guicursor=
syntax off

" setting backup
set backupdir=$HOME/.vim/backup
let &directory = &backupdir

" copy to clipboard
set clipboard=unnamed

" disable mouse
set mouse=

" disable changing current director automatically
set noautochdir
