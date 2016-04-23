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
set smartindent
" set spell
set spelllang=en_us,cjk

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

" disable mouse
set mouse=
