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

local plug_list = require("plugins.list")

require("lazy").setup(
  plug_list
)
