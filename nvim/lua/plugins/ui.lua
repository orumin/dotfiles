return {
---------------------------------------------------------------
--UI
---------------------------------------------------------------
--  {
--    "thinca/vim-splash",
--    event = { "BufWinEnter" },
--    cond = false,
--    optional = true,
--  },
  -- startup display
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config  = require("ui.dashboard")
  },
  -- show buffer like tab
  {
    "willothy/nvim-cokeline",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    keys = require("configs.keymap.cokeline"),
    config = require("ui.cokeline_conf"),
    --cond = false
  },
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    keys = require("configs.keymap.bufferline"),
    config  = require("ui.bufferline_config"),
    cond = false
  },
  -- breadcrumbs (winbar)
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim" }
    },
  },
  -- transparency
--  {
--    'orumin/ya-seiya.nvim',
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
    event = { "BufWinEnter" },
    config = require("ui.transparent_conf"),
    init = function ()
      if require("envutils"):globals().is_headless or vim.g.neovide then
        vim.g.transparent_enabled = false
      end
    end,
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- pretty good UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function ()
          ---@diagnostic disable-next-line: missing-fields
          require("notify").setup({
            background_colour = "#000000"
          })
        end
      },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = require("ui.noice_conf")
  },
  -- status line
--  {
--    "nvim-lualine/lualine.nvim",
--    event = { "BufReadPost", "BufAdd", "BufNewFile" },
--    opts = require("ui.lualine_config"),
--    cond = false
--  },
  {
    "sontungexpt/sttusline",
    event = { "BufEnter" },
    config = require("ui.sttusline_conf"),
  },
  -- scroll minimap
  {
    "dstein64/nvim-scrollview",
    event = "BufReadPost",
    config = true,
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = {"CursorHold", "CursorHoldI"},
    dependencies = {
      { "anuvyklack/hydra.nvim" }
    },
    keys = require("configs.keymap.hydra").git,
    config = function()
      local Hydra = require("hydra")
      Hydra(require("ui.hydra_conf").setup["git"]())
    end
  },
  -- Hydra
  {
    "anuvyklack/hydra.nvim",
    lazy = true
  }
}
