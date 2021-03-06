if has('nvim') || has('job') && has('channel') && has('timers')
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
          \   'right': [ ['percent'], [ 'fileformat', 'fileencoding', 'filetype'], ['ale']]
          \ },
          \ 'component_function': {
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'ale': 'LLAle',
          \ },
          \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
          \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
          \ }
else
    let g:lightline = {
          \ 'colorscheme': 'wombat',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
          \   'right': [ [ 'lineinfo', 'syntastic' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype']]
          \ },
          \ 'component_function': {
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'syntastic': 'SyntasticStatuslineFlag',
          \ },
          \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
          \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
          \ }
endif
 
function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
"  return &ft !~? 'help' && &readonly ? "\u2b64" : ''
  return &ft !~? 'help' && &readonly ? "\ue0a2" : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

if has('nvim') || has('job') && has('channel') && has('timers')
  function! LLAle()
    let l:count = ale#statusline#Count(bufnr(''))
    let l:errors = l:count.error + l:count.style_error
    let l:warnings = l:count.warning + l:count.style_warning
    return l:count.total == 0 ? 'OK' : 'E:' . l:errors . ' W:' . l:warnings
  endfunction
else
  function! LLAle()
    return ''
  endfunction
endif
