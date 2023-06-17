return {
---------------------------------------------------------------
--UI
---------------------------------------------------------------
  {
    "thinca/vim-splash",
    lazy = true,
    event = { "BufWinEnter" },
    cond = false,
    optional = true,
  },
  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config  = require("ui.bufferline")
  },
  -- color schemes
  {
    "tanvirtin/monokai.nvim"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = require("ui.catppuccin"),
  },
  -- transparency
  {
    'orumin/ya-seiya.nvim',
    lazy = true,
    event = { "BufWinEnter" },
    name = "seiya",
    opts = {
      auto_enabled = true,
      target_groups = {"ctermbg"}
--      target_groups = {"ctermbg", "guibg"}
    }
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
        },
      },
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("ui.noice")
  },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = require("ui.lualine")
  },
  -- file tree
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
    opts = {
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
      }
    },
  },
  -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = "BufReadPost",
    opts = {}
  },
  -- scroll minimap
  {
    "dstein64/nvim-scrollview",
    lazy = true,
    event = "BufReadPost",
    opts = {}
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = {"FocusLost", "CursorHold"},
    opts = {}
  },
}

