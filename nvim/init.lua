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

require('plugins')
require('core.basic')
require('core.autocmd')
require('core.keymaps')
require('core.encoding')

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

vim.api.nvim_set_option('filetype', 'on')
vim.api.nvim_set_option('syntax', 'on')
