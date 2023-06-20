local settings = require("configs.global_settings")
return {
---------------------------------------------------------------
-- common plugin
---------------------------------------------------------------
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "vim-denops/denops.vim",
    cond = settings.use_denops or settings.use_skk,
    lazy = false,
  },
---------------------------------------------------------------
-- File tree explorer
---------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    cmd = "Neotree",
    branch = "v2.x",
    keys = require("configs.keymap").neotree,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = require("configs.plugin.editor.neotree"),
  },
---------------------------------------------------------------
-- Fuzzy Finder
---------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    keys = require("configs.keymap").telescope,
    opts = require("configs.plugin.editor.telescope"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    }
  },
---------------------------------------------------------------
-- Debugger Adapter Protocol
---------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate"
    },
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {}
      },
    },
  },
---------------------------------------------------------------
-- improve editor feature
---------------------------------------------------------------
  -- sae/restore session like IDE
  {
    "rmagatti/auto-session",
    lazy = true,
    cmd = { "Autosession", "SessionSave", "SessionRestore", "SessionDelete" },
    init = function ()
      vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    opts = require("configs.plugin.editor.auto-session")
  },
  -- auto size window
  {
    "anuvyklack/windows.nvim",
    lazy = true,
    cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize", },
    dependencies = {
      "anuvyklack/middleclass",
    },
    keys = require("configs.keymap").windows,
    opts = {},
  },
  -- improve buffer delete command
  {
    "ojroques/nvim-bufdel",
    lazy = true,
    event = "BufReadPost",
  },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = "BufReadPost",
    opts = {}
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = true,
    keys = require("configs.keymap").accelerated_jk,
    event = "VeryLazy",
  },
  -- cheetsheet
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    init = function ()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {}
  },
  -- fix ambiwidth character width by 'setcellwidths()'
  {
    "rbtnn/vim-ambiwidth",
    lazy = false,
    cond = vim.fn.has("nvim-0.9") == 1,
  },
  -- project local setting
  {
    "klen/nvim-config-local",
    opts = {
      config_files = { ".nvim.lua", ".nvimrc" },
      hashfile = nvim_data_dir .. path_sep .. "config-local",

      autocommands_create = false,
      commands_create = false,
      silent = false,
      lookup_parents = false,
    }
  },
}

