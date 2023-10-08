local default_keymaps = require("configs.keymap")[1]

local get_opts = function(keys)
  local skip = { mode = true, ft = true, rhs = true, lhs = true }
  local ret = {}
  for k, v in pairs(keys) do
    if type(k) ~= "number" and not skip[k] then
      ret[k] = v
    end
  end
  return ret
end

for _, v in ipairs(default_keymaps) do
  local opts = get_opts(v)
  local lhs = v.lhs or v[1]
  local rhs = v.rhs or v[2]
  local mode = v.mode or "n"
  vim.keymap.set(mode, lhs, rhs, opts)
end
