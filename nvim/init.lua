vim.cmd('autocmd!')
vim.cmd('set shell=bash')

vim.cmd('let g:loaded_clipboard_provider = 1')

-- terminal
-- nnoremap <silent> vt :terminal<CR>
vim.cmd [[
:let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if $COLORTERM == "truecolor"
    :let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
    "set guicolors
endif
]]

vim.api.nvim_set_option('t_Co', '256')

require('core.basic')
require('plugins.dein')
-- vim.cmd('runtime! rc/init/*.vim')
-- vim.cmd('runtime! rc/plugins/*.vim')

-- color and colorscheme settings
vim.cmd('let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0')
vim.cmd[[
if $COLORTERM == "truecolor"
"    silent! colorscheme oak
    let g:nvcode_termcolors=256
    silent! colorscheme nvcode
else
    silent! colorscheme tender
endif
"colorscheme japanesque
]]

vim.cmd('filetype on')
vim.cmd('syntax off')
