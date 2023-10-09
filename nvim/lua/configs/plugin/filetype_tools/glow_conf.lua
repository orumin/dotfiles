local opts = {
  border = "rounded",
  style = "dark",
  width_ratio = 0.8,
  height_ratio = 0.8
}

return function ()
  require("glow").setup(opts)
end
