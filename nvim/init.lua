if vim.loader then
  vim.loader.enable()
end

if vim.g.vscode then
  return
end

vim.o.shell = "bash"

local utils = require("lib")
utils.disable_rtp_plugins()

require('plugins')
require('core.autocmd')
require('core.basic')
require('core.diagnostic')
require('core.encoding')
require('core.keymaps')

local color
if vim.env.COLORTERM and
  vim.env.COLORTERM == "truecolor" then
  vim.o.termguicolors = true
  if gui_running then
    vim.o.guicolors = true
  end
  color = "catppuccin"

else
  vim.o.t_Co = "256"
  color = "monokai"
end

vim.cmd.colorscheme(color)

