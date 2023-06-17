return {
---------------------------------------------------------------
-- common plugin
---------------------------------------------------------------
  { "nvim-lua/plenary.nvim", lazy = true },
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
  -- project local setting
  {
    "klen/nvim-config-local",
    opts = {
      config_files = { ".nvim.lua", ".nvimrc" },
      hashfile = vim.fn.stdpath("data") .. path_sep .. "config-local",

      autocommands_create = false,
      commands_create = false,
      silent = false,
      lookup_parents = false,
    }
  },
}

