local util = require("lib")
local palette = util.get_palette()
local opts = {
  border = "rounded",
  style = vim.env.XDG_CONFIG_HOME .. "/glamour/themes/latte.json",
  width_ratio = 0.8,
  height_ratio = 0.8,
  background = palette.text,
}

return function ()
  require("glow").setup(opts)
end
