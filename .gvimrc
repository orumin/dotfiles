colorscheme wombat256

set columns=80
set lines=40

set guioptions=aerL
set guifont=Consolas:h10:Lucida_Console:h10:w5
set guifontwide=MS_Gothic:h10
if has('kaoriya')
  autocmd FocusGained * set transparency=230
  autocmd FocusLost * set transparency=156
elseif executable('vimtweak.dll')
  autocmd FocusGained * call libcallnr('vimtweak.dll', 'SetAlpha', 230)
  autocmd FocusLost * call libcallnr('vimtweak.dll', 'SetAlpha', 156)
endif

" setting IME
if has('multi_byte_ime') || has('xim')
  highlight CursorIM guibg=Purple guifg=NONE
endif

let IM_CtrlMode - 4
inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

