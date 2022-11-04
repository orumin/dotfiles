call ddu#custom#patch_global({
\   'ui': 'ff',
\   'source': [
\     {
\       'name': 'file_rec',
\       'params': {
\         'ignoredDirectories': ['.git', 'node_modules', 'vendor', '.next']
\       }
\     }
\   ],
\   'sourceOptions': {
\     '_': {
\       'matchers': ['matcher_substring']
\     }
\   },
\   'filterParams': {
\     'matcher_substring': {
\       'highlightMatched': 'Title',
\     }
\   },
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     }
\   },
\   'uiParams': {
\     'ff': {
\       'startFilter': v:true,
\       'prompt': '> ',
\       'split': 'floating',
\     }
\   },
\ })

call ddu#custom#patch_local('grep', {
\   'sourceOptions': {
\     'rg': {
\       'args': ['--column', '--no-heading', '--color', 'never']
\     }
\   },
\   'uiParams': {
\     'ff': {
\       'startFilter': v:false,
\     }
\   },
\ })

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
    nnoremap <buffer><silent> <CR>
      \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>

    nnoremap <buffer><silent> <Space>
      \ <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'split'}})<CR>

    nnoremap <buffer><silent> a
      \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>

    nnoremap <buffer><silent> p
      \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>

    nnoremap <buffer><silent> <ESC>
      \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_my_settings()
function! s:ddu_my_settings() abort
    inoremap <buffer><silent> <CR>
      \ <ESC><Cmd>close<CR>

    inoremap <buffer><silent> <ESC>
      \ <ESC><Cmd>close<CR>

    nnoremap <buffer><silent> <CR>
      \ <Cmd>close<CR>

    nnoremap <buffer><silent> <ESC>
      \ <Cmd>close<CR>
endfunction

nmap <silent> ;f <Cmd>call ddu#start({})<CR>
nmap <silent> ;g <Cmd>call ddu#start({
\   'name': 'grep',
\   'sources':[
\     {'name': 'rg', 'params': {'input': expand('<cword>')}}
\   ],
\ })<CR>
