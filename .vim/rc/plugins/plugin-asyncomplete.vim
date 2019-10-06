au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'look',
    \ 'whitelist': ['rst', 'markdown', 'asciidoc', 'pandoc', 'gitrebase', 'gitcommit', 'vcs-commit', 'hybrid', 'text', 'help', 'tex'],
    \ 'completor': function('asyncomplete#sources#look#completor'),
    \ })

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
