local utils = require("envutils")
local G = utils:globals()
return {
---------------------------------------------------------------
--UI
---------------------------------------------------------------
--  {
--    "thinca/vim-splash",
--    lazy = true,
--    event = { "BufWinEnter" },
--    cond = false,
--    optional = true,
--  },
  -- startup display
  {
    "goolord/alpha-nvim",
    lazy = true,
    event = "VimEnter",
    config  = require("ui.dashboard")
  },
  -- show buffer like tab
  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    keys = require("configs.keymap").bufferline,
    config  = require("ui.bufferline_config")
  },
  -- breadcrumbs (winbar)
  {
    "Bekaboo/dropbar.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", lazy = true }
    },
  },
  -- color schemes
  {
    "tanvirtin/monokai.nvim"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = require("ui.catppuccin_conf"),
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
    config = require("ui.transparent_conf"),
    init = function ()
      if G.is_headless or vim.g.neovide then
        vim.g.transparent_enabled = false
      end
    end,
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim", lazy = true },
      {
        "rcarriga/nvim-notify",
        lazy = true,
        event = "VeryLazy",
        config = function ()
          ---@diagnostic disable-next-line: missing-fields
          require("notify").setup({
            background_colour = "#000000"
          })
        end
      },
      { "nvim-treesitter/nvim-treesitter", lazy = true }
    },
    config = require("ui.noice_conf")
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
    event = {"CursorHold", "CursorHoldI"},
    dependencies = {
      { "anuvyklack/hydra.nvim", lazy = true }
    },
    keys = require("configs.keymap").hydra["git"],
    config = function()
      local Hydra = require("hydra")
      Hydra(require("ui.hydra_conf").setup["git"]())
    end
  },
  -- Hydra
  {
    "anuvyklack/hydra.nvim",
    lazy = true,
  }
}

