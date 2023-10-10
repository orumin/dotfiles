local utils = require("utils")
local G = utils.globals()
local palette = utils.get_palette()
local opts = {
  border = "rounded",
  style = G.config_home .. "/glamour/themes/latte.json",
  width_ratio = 0.8,
  height_ratio = 0.8,
  background = palette.text,
}

return function ()
  require("glow").setup(opts)
end
