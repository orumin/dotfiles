local settings = require("configs.global_settings")
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

package.path = package.path .. ";" .. plugin_config_dir .. path_sep .. "?.lua;" .. plugin_config_dir .. path_sep .. "?" .. path_sep .. "init.lua"

local disabled_plugins = {}
local count = 1
for k, _ in pairs(settings.disabled_rtp_plugins) do
  disabled_plugins[count] = k
  count = count + 1
end

local lazy_opts = {
  root = nvim_data_dir .. path_sep .. "lazy",
  defauls = { lazy = false, version = nil, cond = nil },
  spec = {
    { import = "plugins" }, -- load plugin list from vim.fn.stdpath("config") .. "/lua/plugins/?.lua"
  },
  lockfile = nvim_config_dir .. path_sep .. "lazy-lock.json",
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
    ui = {
      wrap = true,
      border = "rounded",
    },
  },
  diff = { cmd = "git" },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = disabled_plugins,
    },
  }
}

vim.opt.runtimepath:prepend(lazypath)
require("lazy").setup(lazy_opts)
