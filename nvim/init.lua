vim.env.IN_NVIM = "1"

if vim.loader then
  vim.loader.enable()
end

if vim.g.vscode then
  return
end

local settings = require("configs")
vim.g.mapleader = settings.mapleader

-- load utilities
local utils = require("envutils")
utils:setup()

-- should call before load 'core.plugin'
local color = require("core.color")

-- load plugins
require('core.plugin')

-- basic settings
require('core.autocmd')
require('core.basic')
--require('core.encoding')
require('core.keymaps')
require('core.lsp').setup()
-- setup colorscheme
color.settings()

-- setup neovide
require("configs.neovide")
