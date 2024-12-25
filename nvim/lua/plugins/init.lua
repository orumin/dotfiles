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
local lazypath = utils:path_concat({G.nvim_data_dir, "lazy","lazy.nvim"})

local uv = vim.uv

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

local plugin_config_search_path = utils:path_concat({G.plugin_config_dir, "?.lua"})
local plugin_config_init_search_path = utils:path_concat({G.plugin_config_dir, "?", "init.lua"})
package.path = table.concat({package.path, plugin_config_search_path, plugin_config_init_search_path}, ";")

local disabled_plugins = {}
local count = 1
for k, _ in pairs(configs.disabled_rtp_plugins) do
  disabled_plugins[count] = k
  count = count + 1
end

local lazy_opts = {
  root = utils:path_concat({G.nvim_data_dir, "lazy"}),
  defauls = { lazy = true, version = nil, cond = nil },
  spec = nil,
  local_spec = true,
  lockfile = utils:path_concat({G.nvim_config_dir, "lazy-lock.json"}),
  concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
  git = {
    log = { "-8" },
    timeout = 120,
    url_format = "https://github.com/%s.git",
    filter = true,
    throttole = {
      enabled = false,
      rate = 2,
      duration = 5 * 1000, -- in ms
    },
    cooldown = 0,
  },
  pkg = {
    enabled = true,
    cache = utils:path_concat({G.nvim_state_dir, "lazy", "pkg-cache.lua"}),
    sources = {
      "lazy",
      "rockspec",
      "packspec"
    },
  },
  rocks = {
    enabled = true,
    root = utils:path_concat({G.nvim_data_dir, "lazy-rocks"}),
    server = "https://nvim-neorocks.github.io/rocks-binaries/",
    hererocks = nil,
  },
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  diff = { cmd = "git" },
  ui = {
    wrap = true,
    border = configs.window_style.border,
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
  browser = G.browser,
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
  },
  readme = {
    enabled = true,
    root = utils:path_concat({G.nvim_state_dir, "lazy", "readme"}),
    files = { "README.md", "lua/**/README.md" },
    skip_if_doc_exists = true,
  },
  state = utils:path_concat({G.nvim_state_dir, "lazy", "state.json"}),
  profiling = {
    loader = true,
    require = true,
  }
}

vim.opt.runtimepath:prepend(lazypath)
lazy_opts.spec = {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
    init = function ()
      local termcolor = require("configs.ui.termcolor")
      for k, v in pairs(termcolor) do
        vim.g[k] = v
      end

      vim.cmd.colorscheme("catppuccin")
    end,
    config = require("ui.catppuccin_conf"),
  },
  { import = "plugins.editor" },
  { import = "plugins.ui" },
  { import = "plugins.treesitter" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.tools" },
  { import = "plugins.filetype_tools" },
  { import = "plugins.misc" },
  {
    "options",
    lazy = true,
    event = "VeryLazy",
    dir = G.nvim_config_dir,
    init = function()
      require('core.autocmd')
      require('core.filetypes')
      require('core.lsp').setup()
    end,
    config = function()
      -- basic settings
      local core = require('core') --[[@as NvimConfMyCore]]
      core.finalize()
      --require('core.encoding')
      require('core.keymaps')

      -- setup neovide
      require("configs.neovide")
      pcall(vim.cmd.rshada, { bang = true })
    end
  }
}
require("lazy").setup(lazy_opts)
