set completeopt=menuone

let g:deoplete#enable_at_startup = 1
let g:deoplete#max_list = 20
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case_completion = 1
let g:deoplete#enable_underbar_completion = 0
let g:deoplete#use_vimproc = 1
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#text_mode_filetypes = {
            \ 'rst': 1,
            \ 'markdown': 1,
            \ 'gitrebase': 1,
            \ 'gitcommit': 1,
            \ 'vcs-commit': 1,
            \ 'hybrid': 1,
            \ 'text': 1,
            \ 'help': 1,
            \ 'tex': 1,
            \ }

