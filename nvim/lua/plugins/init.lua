local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local uv = nil
if vim.uv then uv = vim.uv else uv = vim.loop end

if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end

vim.opt.runtimepath:prepend(lazypath)

local plug_list = require("plugins.list.main")
local lazy_load_plug_list = require("plugins.list.lazy_load")

for _, v in pairs(lazy_load_plug_list) do
  v.lazy = true
  table.insert(plug_list, v)
end

require("lazy").setup(
  plug_list
)
