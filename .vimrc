autocmd!

set shell=bash

"set t_Co=256

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

set hidden " open file ignoring modify files
set autoread " reload file if file is editted by external system

" indent, tabwidth
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
autocmd FileType text setlocal textwidth=78
set modeline
set modelines=5

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

"" setting backup
"set backupdir=$HOME/.vim/backup
"let &directory = &backupdir

" copy to clipboard
set clipboard=unnamed

" disable mouse
set mouse=

" disable changing current director automatically
set noautochdir

nnoremap ; :
:map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
:map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap \s :set spell!<CR>

" this setting quoted from http://www.kawaz.jp/pukiwiki/?vim#content_1_7

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
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
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
"  set ambiwidth=double
" Gnome Terminal を利用しなくても Illusion N フォント使う前提でこっちにする
"" Gnome Terminalだといろいろブッ壊れるのでsingleに
  set ambiwidth=single
endif

if $COLORTERM == "truecolor"
"    silent! colorscheme oak
    let g:nvcode_termcolors=256
    silent! colorscheme nvcode
else
    silent! colorscheme tender
endif
"colorscheme japanesque

filetype on
