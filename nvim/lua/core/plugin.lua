local utils = require("envutils")
local G = utils:globals()
local configs = require("configs")
local icons = {
  documents = require("configs.ui.icons").get("documents"),
  kind = require("configs.ui.icons").get("kind"),
  misc = require("configs.ui.icons").get("misc"),
  ui = require("configs.ui.icons").get("ui"),
  ui_sep = require("configs.ui.icons").get("ui", true),
}
local lazypath = G.nvim_data_dir .. G.path_sep .. "lazy" .. G.path_sep .. "lazy.nvim"

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

package.path = package.path .. ";" .. G.plugin_config_dir .. G.path_sep .. "?.lua;" .. G.plugin_config_dir .. G.path_sep .. "?" .. G.path_sep .. "init.lua"

local disabled_plugins = {}
local count = 1
for k, _ in pairs(configs.disabled_rtp_plugins) do
  disabled_plugins[count] = k
  count = count + 1
end

local lazy_opts = {
  root = G.nvim_data_dir .. G.path_sep .. "lazy",
  defauls = { lazy = false, version = nil, cond = nil },
  spec = {
    { import = "plugins" }, -- load plugin list from vim.fn.stdpath("config") .. "/lua/plugins/?.lua"
  },
  lockfile = G.nvim_config_dir .. G.path_sep .. "lazy-lock.json",
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  diff = { cmd = "git" },
  ui = {
    wrap = true,
    border = "rounded",
    margin = {
      top = 0,
      right = 0,
      botoom = 0,
      left = 0
    },
    icons = {
      cmd = icons.misc.Code,
      config = icons.ui.Gear,
      event = icons.kind.Event,
      ft = icons.documents.Files,
      init = icons.misc.ManUp,
      import = icons.documents.Import,
      keys = icons.ui.Keyboard,
      loaded = icons.ui.Check,
      not_loaded = icons.misc.Ghost,
      plugin = icons.ui.Package,
      runtime = icons.misc.Vim,
      source = icons.kind.StaticMethod,
      start = icons.ui.Play,
      list = {
        icons.ui_sep.BigCircle,
        icons.ui_sep.BigUnfilledCircle,
        icons.ui_sep.Square,
        icons.ui_sep.ChevronRight,
      },
    },
  },
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
