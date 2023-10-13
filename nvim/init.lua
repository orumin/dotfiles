vim.env.IN_NVIM = "1"

if vim.loader then
  vim.loader.enable()
end

if vim.g.vscode then
  return
end

local utils = require("envutils")
utils:setup()

local color = require("core.color")

require('core.plugin')

require('core.autocmd')
require('core.basic')
require('core.diagnostic')
--require('core.encoding')
require('core.keymaps')

color.settings()

require("configs.neovide")
