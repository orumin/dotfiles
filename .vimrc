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
  let $PATH='Y:/application/msysGit/bin;'.
	  \'Y:/application/msysGit/mingw/bin;'.$PATH
endif

"---------------------------------------------------
" setting NeoBundle
filetype off

if has('vim_starting')
  if ( ostype == 'Win' )
	set runtimepath+=$VIM/vimfiles/bundle/neobundle
	call neobundle#rc(expand('$VIM/vimfiles/bundle'))
  else
	set runtimepath+=~/.vim/bundle/neobundle
	call neobundle#rc(expand('~/.vim/bundle'))
  endif
endif 

NeoBundle 'Shougo/neobundle.vim', {'directory' : 'neobundle'}
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim', {'directory' : 'unite'}
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
	\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
	\     'cygwin' : 'make -f make_cygwin.mak',
	\     'mac' : 'make -f make_mac.mak',
	\     'unix' : 'make -f make_unix.mak',
	\    },
	\ }

NeoBundle 'trinity.vim', {'directory' : 'trinity'}

" tweetvim
NeoBundle 'basyura/TweetVim'
NeoBundle 'basyura/twibill.vim', {'directory' : 'twibill'}
NeoBundle 'basyura/bitly.vim', {'directory' : 'bitly'}
NeoBundle 'tyru/open-browser.vim', {'directory' : 'open-browser'}
NeoBundle 'mattn/webapi-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'yomi322/neco-tweetvim'
NeoBundle 'yomi322/unite-tweetvim'

NeoBundle 'Color-Sampler-Pack'

filetype plugin indent on
"---------------------------------------------------

source $VIMRUNTIME/delmenu.vim
set langmenu=none
source $VIMRUNTIME/menu.vim

if has('multi_lang')
  language C
endif

" setting encoding
set fileencoding=UTF-8
set encoding=UTF-8
if ( ostype=='Win')
  set termencoding=CP932
else
  set termencoding=UTF-8
endif

set hidden " open file ignoring modify files
set autoread

"indent, tabwidth
set shiftwidth=2
set tabstop=4
set softtabstop=4
set noexpandtab
set textwidth=78
if has( 'kaoriya' )
  set ambiwidth=auto
else
  set ambiwidth=single
endif

" setting search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" setting edit
set backspace=indent,eol,start
set showmatch
set autoindent
set cindent

" setting display
set ruler
set showcmd
set number
set matchtime=3
set laststatus=2
set cmdheight=2
set wildmenu
syntax on

" setting backup
if ( ostype == 'Win' )
  set backupdir=$VIM/vimfiles/backup
else
  set backupdir=~/backup
endif
let &directory = &backupdir

colorscheme neon

"------------------------------------------
" disable default vim plugin of Kaoriya ver
let plugin_autodata_diable	= 1
let plugin_cmdex_disable	= 1
let plugin_dicwin_disable	= 1
let plugin_format_disable	= 1
let plugin_hz_ja_disable	= 1
let plugin_scrnmode_disable	= 1
" let plugin_verifyenc_disable	= 1
"------------------------------------------

"---------------------------------------------
" other setting
nmap ; :
autocmd FileType tweetvim set wrap
autocmd FileType !tweetvim set nowrap

"---------------------------------------------
" setting plugin

nnoremap <silent> t :Unite tweetvim<CR>
nnoremap <silent> s :TweetVimSay<CR>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

