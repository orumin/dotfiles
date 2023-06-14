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

package.path = package.path .. ";" .. plugin_config_dir .. "/?.lua;" .. plugin_config_dir .. "/?/init.lua"
local plug_list = require("plugins.list")

local lazy_opts = {
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  ui = {
    wrap = true,
    border = "rounded",
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
      disable_events = { "UIEnter", "BufReadPre" },
      ttl = 3600 * 24 * 2,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
    }
  }
}

vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup(
  plug_list, lazy_opts
)
