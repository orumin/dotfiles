colorscheme wombat256

set columns=100
set lines=32

set guioptions=aerL
set guifont=Consolas:h10,Lucida_Console:h10:w5
set guifontwide=MS_Gothic:h10
gui
set transparency=230

" setting IME
if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
endif

let IM_CtrlMode = 4
inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

