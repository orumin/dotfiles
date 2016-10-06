"nnoremap <silent> t :Unite tweetvim<CR>
nnoremap <silent> s :TweetVimSay<CR>
nnoremap <leader>us :TweetVimUserStream<CR>
nmap <space>t <Plug>(tweetvim)
let g:tweetvim_display_source=1
let g:tweetvim_display_icon=1
let g:tweetvim_open_buffer_cmd='split'
autocmd FileType tweetvim setlocal wrap
autocmd FileType tweetvim_say setlocal wrap

