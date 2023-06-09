if vim.loader then
  vim.loader.enable()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

local ok, plug_list, lazy_load_plug_list, ddc_plug_list, ddu_plug_list

ok, plug_list = pcall(require, "plugins.list.main")
if not ok then
  return
end

ok, lazy_load_plug_list = pcall(require, "plugins.list.lazy_load")
if ok then
  for _, v in pairs(lazy_load_plug_list) do
    table.insert(plug_list, v)
  end
end

require("lazy").setup(
  plug_list
)
