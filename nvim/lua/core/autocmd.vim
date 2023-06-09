augroup MyAutoGroup

autocmd FileType text setlocal textwidth=78
"autocmd BufWritePost .vimrc source ~/.vimrc
"autocmd BufWritePost .gvimrc source ~/.gvimrc
"set ft=vim

" md as markdown, instead of modula2
" autocmd MyAutoGroup BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set ft=markdown

" yml as ansible, instead of yaml
autocmd MyAutoGroup BufNewFile,BufRead *.yml set ft=ansible
" change shift width when yml and yaml editing
autocmd MyAutoGroup BufNewFile,BufRead *.{yaml,yml} set shiftwidth=2

augroup END
