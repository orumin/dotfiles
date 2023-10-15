local utils = require("envutils")
local G = utils:globals()
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
    branch = "v3.x",
    keys = require("configs.keymap").neotree,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        name = "window-picker",
        opts = require("editor.window_picker"),
      },
    },
    opts = require("editor.neotree"),
  },
---------------------------------------------------------------
-- Fuzzy Finder
---------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    config = require("editor.telescope_conf"),
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "fdschmidt93/telescope-egrepify.nvim",
      "folke/trouble.nvim",
      {
        "rmagatti/session-lens",
        dependencies = {
          "rmagatti/auto-session"
        }
      },
      "debugloop/telescope-undo.nvim"
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
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jbyuki/one-small-step-for-vimkind",
      "jay-babu/mason-nvim-dap.nvim"
    },
    config = require("editor.dap_conf")
  },
---------------------------------------------------------------
-- improve editor feature
---------------------------------------------------------------
  -- listchar
  {
    "fraso-dev/nvim-listchars",
    lazy = true,
    event = "VeryLazy",
    config = require("editor.listchars")
  },
  -- save/restore session like IDE
  {
    "rmagatti/auto-session",
    lazy = true,
    cmd = { "Autosession", "SessionSave", "SessionRestore", "SessionDelete" },
    init = function ()
      vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    opts = require("editor.auto-session")
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
    config = true,
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
    config = true,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = true,
    keys = require("configs.keymap").accelerated_jk,
    event = "VeryLazy",
  },
  -- improve highlight
  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = require("editor.illuminate_conf"),
  },
  -- support write regex
  {
    "tomiis4/Hypersonic.nvim",
    name = "hypersonic",
    lazy = true,
    event = "CmdlineEnter",
    cmd = "Hypersonic",
    config = true,
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
    config = true,
  },
  -- fix ambiwidth character width by 'setcellwidths()'
  {
    "rbtnn/vim-ambiwidth",
    lazy = false,
    --cond = vim.fn.has("nvim-0.9") == 1,
    cond = false,
  },
  -- project local setting
  {
    "klen/nvim-config-local",
    opts = {
      config_files = { ".nvim.lua", ".nvimrc" },
      hashfile = G.nvim_data_dir .. G.path_sep .. "config-local",

      autocommands_create = false,
      commands_create = false,
      silent = false,
      lookup_parents = false,
    },
    cond = false,
  },
}

