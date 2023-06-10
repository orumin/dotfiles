vim.cmd('autocmd!')
vim.o.shell = "bash"

vim.api.nvim_set_var("loaded_clipboard_provider", "1")

require('plugins')
require('core.basic')
require('core.autocmd')
require('core.keymaps')
require('core.encoding')
require('core.color')

vim.api.nvim_set_option('filetype', 'on')
vim.api.nvim_set_option('syntax', 'on')
