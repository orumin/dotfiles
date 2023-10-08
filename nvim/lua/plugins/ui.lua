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
    keys = require("configs.keymap").bufferline,
    config  = require("ui.bufferline_config")
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
--  {
--    'orumin/ya-seiya.nvim',
--    lazy = true,
--    event = { "BufWinEnter" },
--    name = "seiya",
--    opts = {
--      auto_enabled = true,
--      target_groups = {"ctermbg"}
----      target_groups = {"ctermbg", "guibg"}
--    }
--  },
  {
    "xiyaowong/transparent.nvim",
    lazy = true,
    event = { "BufWinEnter" },
    config = require("ui.transparent_conf")
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
    opts = require("ui.lualine_config")
  },
  -- scroll minimap
  {
    "dstein64/nvim-scrollview",
    lazy = true,
    event = "BufReadPost",
    config = true,
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = {"FocusLost", "CursorHold"},
    config = true,
  },
  -- Hydra
  {
    "anuvyklack/hydra.nvim",
    name = "hydra",
    lazy = false,
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    config = require("ui.hydra_conf")
  }
}
