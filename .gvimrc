colorscheme wombat256

set columns=110
set lines=40

set guioptions=aerL

if has('win32')
  set guifont=Consolas:h10:Lucida_Console:h10:w5
  set guifontwide=MS_Gothic:h10
else
"  set guifont=Ricty:h10:IPA_Gothic:h10:w5
"  set guifontwide=VL_Gothic:h10
endif

if has('kaoriya')
  autocmd FocusGained * set transparency=230
  autocmd FocusLost * set transparency=156
elseif executable('vimtweak.dll')
  autocmd FocusGained * call libcallnr('vimtweak.dll', 'SetAlpha', 230)
  autocmd FocusLost * call libcallnr('vimtweak.dll', 'SetAlpha', 156)
endif

"" setting IME
"if has('multi_byte_ime') || has('xim')
"  highlight CursorIM guibg=Purple guifg=NONE
"endif
"
"let IM_CtrlMode = 4
"inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>

