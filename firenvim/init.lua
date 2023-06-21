local nvim_data_dir = vim.fn.stdpath("data")
local path_sep = is_win and "\\" or "/"

local lazypath = nvim_data_dir .. path_sep .. "lazy" .. path_sep .. "lazy.nvim"

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

require("lazy").setup({
  "glacambre/firenvim",
  cond = not not vim.g.started_by_firenvim,
  build = function ()
    require("lazy").load({ plugins = "firenvim", wait = true })
    vim.fn["firenvim#install"](0)
  end
})

