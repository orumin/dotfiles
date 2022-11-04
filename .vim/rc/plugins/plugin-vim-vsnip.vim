" Expand
imap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-l>'
smap <expr> <C-l> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-l>'
" Jump forward or backward
imap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
smap <expr> <C-f> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<C-f>'
imap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
smap <expr> <C-b> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>'
let g:vsnip_snippet_dir = expand('~/.vim/snippets')

"function s:trigger_completedone()
"  let info = pum#complete_info()
"  let complete_item = info.items[info.selected]
"  call vsnip_integ#on_complete_done(complete_item)
"  return "\<Ignore>"
"endfunction
"imap <expr> <C-v> <SID>trigger_completedone()
