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
-- options toggle menu
---------------------------------------------------------------
{
    "gregorias/toggle.nvim",
    event = "VeryLazy",
    version = "2.0",
    dependencies = {
      { "folke/which-key.nvim" }
    },
    config = true,
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
      { "debugloop/telescope-undo.nvim" },
      { "cathyprime/hydra.nvim" }
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
      { "cathyprime/hydra.nvim" }
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
  {
    "pteroctopus/faster.nvim",
    lazy = false,
    config = true,
  },
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
  -- manage session
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = require("editor.persistence_conf"),
    keys = require("configs.keymap.persistence"),
  },
  -- create and management window layout
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    config = require("editor.edgy_conf"),
    cond = false,
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
  -- buffer navigation
  {
    "leath-dub/snipe.nvim",
    keys = require("configs.keymap.snipe"),
    config = true,
  },
  -- encourage regex writing
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
    dependencies = {
      { "echasnovski/mini.icons" }
    },
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
