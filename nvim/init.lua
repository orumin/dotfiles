if vim.g.vscode then
  return
end

if vim.loader then
  vim.loader.enable()
end

if not _G.pr_error then
  _G.pr_error = function(msg, opts)
    vim.notify(msg, vim.log.levels.ERROR, opts)
  end
end

vim.cmd('autocmd!')
vim.o.shell = "bash"

vim.api.nvim_set_var("loaded_clipboard_provider", "1")

require('plugins')
require('core.autocmd')
require('core.basic')
require('core.color')
require('core.diagnostic')
require('core.encoding')
require('core.keymaps')

vim.api.nvim_set_option('filetype', 'on')
vim.api.nvim_set_option('syntax', 'on')
