if vim.loader then
  vim.loader.enable()
end

if vim.g.vscode then
  return
end

local utils = require("lib")
utils.disable_rtp_plugins()
utils.setting_shell()

local color = require("core.color")

require('core.plugin')

require('core.autocmd')
require('core.basic')
require('core.diagnostic')
--require('core.encoding')
require('core.keymaps')

color.settings()

