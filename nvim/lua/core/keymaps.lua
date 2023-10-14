local default_keymaps = require("configs.keymap")[1]
local utils = require("envutils")

for _, v in ipairs(default_keymaps) do
  local opts = utils.get_keymap_opts(v)
  local lhs = v.lhs or v[1]
  local rhs = v.rhs or v[2]
  local mode = v.mode or "n"
  vim.keymap.set(mode, lhs, rhs, opts)
end
