if vim.loader then
  vim.loader.enable()
end

if vim.g.vscode then
  return
end

vim.o.shell = "bash"
vim.g["loaded_clipboard_provider"] = 1

require("lib.utils")

require('plugins')
require('core.autocmd')
require('core.basic')
require('core.color')
require('core.diagnostic')
require('core.encoding')
require('core.keymaps')
