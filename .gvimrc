
set columns=110
set lines=40

"set guioptions=aerL
set guioptions-=T

if has('win32')
  set guifont=Consolas:h10:Lucida_Console:h10:w5
  set guifontwide=MS_Gothic:h10
else
    set guifont=Ricty\ 10
    set guifontwide=Ricty\ 10
endif

if has('kaoriya')
  autocmd FocusGained * set transparency=230
  autocmd FocusLost * set transparency=156
elseif executable('vimtweak.dll')
  autocmd FocusGained * call libcallnr('vimtweak.dll', 'SetAlpha', 230)
  autocmd FocusLost * call libcallnr('vimtweak.dll', 'SetAlpha', 156)
endif

