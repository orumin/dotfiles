"let g:ale_sign_error = '>>'
"let g:ale_sign_warning = '⚠'
    
let g:ale_completion = 0
let g:ale_disable_lsp = 1

let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_chagned = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_sh_shellcheck_options = '-e SC1090,SC2059,SC2155,SC2164'

let g:ale_echo_cursor = 0
let g:ale_visualtext_cursor = 1

let g:ale_linters = {'c': ['cc'],
                    \'cpp': ['cc']}

nmap <silent> <Subleader>p <Plug>(ale_previous)
nmap <silent> <Subleader>n <Plug>(ale_next)
nmap <silent> <Subleader>a <Plug>(ale_toggle)

function! s:ale_list()
  let g:ale_open_list = 1
  call ale#Queue(0, 'lint_file')
endfunction
command! ALEList call s:ale_list()
nnoremap <Subleader>m  :ALEList<CR>
autocmd MyAutoGroup FileType qf nnoremap <silent> <buffer> q :let g:ale_open_list = 0<CR>:q!<CR>
autocmd MyAutoGroup FileType help,qf,man,ref let b:ale_enabled = 0

if dein#tap('lightline.vim')
  autocmd MyAutoGroup User ALELint call lightline#update()
endif

"nmap <silent> gn <Plug>(ale_previous_wrap)
"nmap <silent> gv <Plug>(ale_next_wrap)
