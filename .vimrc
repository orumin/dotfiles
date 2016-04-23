autocmd!

" terminal
if has('nvim')
    nnoremap <silent> vt :terminal<CR>
endif

set t_Co=256

runtime! rc/init/*.vim
runtime! rc/plugins/*.vim

colorscheme wombat256

filetype plugin on
