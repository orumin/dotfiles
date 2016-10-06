autocmd!

" terminal
if has('nvim')
    nnoremap <silent> vt :terminal<CR>
    :let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    :let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    "set termguicolors
    "set guicolors
endif

"set t_Co=256

runtime! rc/init/*.vim
runtime! rc/plugins/*.vim

colorscheme wombat256
"colorscheme japanesque

filetype plugin on
