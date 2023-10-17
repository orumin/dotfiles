local utils = require("envutils")
local G = utils:globals()
local configs = require("configs")
return {
---------------------------------------------------------------
-- common plugin
---------------------------------------------------------------
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "vim-denops/denops.vim",
    cond = configs.use_denops or configs.use_skk,
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
      { "nvim-lua/plenary.nvim", lazy = true },
      { "nvim-tree/nvim-web-devicons", lazy = true },
      { "MunifTanjim/nui.nvim", lazy = true },
      {
        "s1n7ax/nvim-window-picker",
        lazy = true,
        name = "window-picker",
        config = require("editor.window_picker"),
      },
    },
    config = require("editor.neotree"),
  },
---------------------------------------------------------------
-- Fuzzy Finder
---------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      { "nvim-tree/nvim-web-devicons", lazy = true },
      { "fdschmidt93/telescope-egrepify.nvim", lazy = true },
      { "folke/trouble.nvim", lazy = true },
      {
        "rmagatti/session-lens",
        lazy = true,
        dependencies = {
          { "rmagatti/auto-session", lazy = true }
        }
      },
      { "debugloop/telescope-undo.nvim", lazy = true },
      { "anuvyklack/hydra.nvim", lazy = true }
    },
    keys = require("configs.keymap").hydra["telescope"],
    config = function ()
      local Hydra = require("hydra")
      require("editor.telescope_conf").setup()
      Hydra(require("ui.hydra_conf").setup["telescope"]())
    end
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
      { "rcarriga/nvim-dap-ui", lazy = true },
      { "theHamsta/nvim-dap-virtual-text", lazy = true },
      { "jbyuki/one-small-step-for-vimkind", lazy = true },
      { "jay-babu/mason-nvim-dap.nvim", lazy = true },
      { "anuvyklack/hydra.nvim", lazy = true }
    },
    keys = require("configs.keymap").hydra["dap"],
    config = function ()
      local Hydra = require("hydra")
      require("editor.dap_conf")()
      Hydra(require("ui.hydra_conf").setup["dap"]())
    end,
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
    config = require("editor.auto-session")
  },
  -- rename improve
  {
    "cshuaimin/ssr.nvim",
    lazy = true,
    keys = require("configs.keymap").ssr,
    config = require("editor.ssr_conf")
  },
  -- auto size window
  {
    "anuvyklack/windows.nvim",
    lazy = true,
    cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize", },
    dependencies = {
      { "anuvyklack/middleclass", lazy = true }
    },
    keys = require("configs.keymap").windows,
    config = true,
  },
  -- improve buffer delete command
  {
    "ojroques/nvim-bufdel",
    lazy = true,
    cmd = { "BufDel", "BufDelAll", "BufDelOthers" }
  },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
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
--    event = { "CursorHold", "CursorHoldI" },
    init = function ()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = require("editor.which-key_conf"),
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
    lazy = true,
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

