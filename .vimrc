autocmd!

set shell=bash

" avoid insert newline at end of file
" WARN: POSIX require newline character at EOF for plain text.
set binary noeol
set nofixeol

" terminal
if has('nvim')
    nnoremap <silent> vt :terminal<CR>
    :let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    if $COLORTERM == "truecolor"
        :let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        set termguicolors
        hi LineNr ctermbg=NONE guibg=NONE
        "set guicolors
    endif
endif

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

runtime! rc/init/*.vim
"runtime! rc/plugins/*.vim

if $COLORTERM == "truecolor"
"    silent! colorscheme oak
    let g:nvcode_termcolors=256
    silent! colorscheme nvcode
else
    silent! colorscheme tender
endif
"colorscheme japanesque

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

filetype plugin on
