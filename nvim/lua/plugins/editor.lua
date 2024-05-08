return {
---------------------------------------------------------------
-- common plugin
---------------------------------------------------------------
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "vim-denops/denops.vim",
    lazy = true,
    cond = require("configs").use_denops or require("configs").use_skk,
  },
---------------------------------------------------------------
-- File tree explorer
---------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    keys = require("configs.keymap.neotree"),
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "MunifTanjim/nui.nvim" },
      {
        "s1n7ax/nvim-window-picker",
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
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "fdschmidt93/telescope-egrepify.nvim" },
      { "folke/trouble.nvim" },
      {
        "rmagatti/session-lens",
        dependencies = {
          { "rmagatti/auto-session" }
        }
      },
      { "debugloop/telescope-undo.nvim" },
      { "nvimtools/hydra.nvim" }
    },
    keys = require("configs.keymap.hydra").telescope,
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
      { "williamboman/mason.nvim" },
      { "jay-babu/mason-nvim-dap.nvim" },
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "jbyuki/one-small-step-for-vimkind" },
      { "anuvyklack/hydra.nvim" }
    },
    keys = require("configs.keymap.hydra").dap,
    config = function ()
      local Hydra = require("hydra")
      require("editor.dap_conf")()
      Hydra(require("ui.hydra_conf").setup["dap"]())
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio"
    }
  },
---------------------------------------------------------------
-- improve editor feature
---------------------------------------------------------------
  -- listchar
  {
    "fraso-dev/nvim-listchars",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("editor.listchars")
  },
  -- show current mode
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    opts = require("editor.reactive")
  },
  -- auto indent like VSCode
  {
    "VidocqH/auto-indent.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = true
  },
  -- save/restore session like IDE
  {
    "rmagatti/auto-session",
    cmd = { "Autosession", "SessionSave", "SessionRestore", "SessionDelete" },
    init = function ()
      vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    config = require("editor.auto-session")
  },
  -- rename improve
  {
    "cshuaimin/ssr.nvim",
    keys = require("configs.keymap.ssr"),
    config = require("editor.ssr_conf")
  },
  -- auto size window
  {
    "anuvyklack/windows.nvim",
    cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize", },
    dependencies = {
      { "anuvyklack/middleclass" }
    },
    keys = require("configs.keymap").windows,
    config = true,
  },
  -- improve buffer delete command
  {
    "ojroques/nvim-bufdel",
    cmd = { "BufDel", "BufDelAll", "BufDelOthers" }
  },
  -- create and management window layout
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    config = require("editor.edgy_conf")
  },
  -- smooth scroll
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      local cond = not vim.g.neovide and not require("envutils"):globals().is_headless
      if cond then
        require("mini.animate").setup()
      end
    end,
  },
  -- improve highlight
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    config = require("editor.illuminate_conf"),
  },
  -- add search panel
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    cmd = "Spectre",
    keys = require("configs.keymap.spectre"),
    config = true
  },
  -- support write regex
  {
    "tomiis4/Hypersonic.nvim",
    name = "hypersonic",
    event = "CmdlineEnter",
    cmd = "Hypersonic",
    config = true,
  },
  -- cheetsheet
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
--    event = { "CursorHold", "CursorHoldI" },
    config = require("editor.which-key_conf"),
  },
  -- project local setting
  {
    "klen/nvim-config-local",
    event = "VeryLazy",
    config = require("editor.local_conf")
  },
}
