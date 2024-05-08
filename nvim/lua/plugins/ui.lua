return {
---------------------------------------------------------------
--UI
---------------------------------------------------------------
--  -- startup display
--  {
--    "goolord/alpha-nvim",
--    event = "VimEnter",
--    config  = require("ui.dashboard")
--  },
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
  },
  -- breadcrumbs (winbar)
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim" }
    },
  },
  -- colorful window separator
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function ()
      require("colorful-winsep").setup()
    end,
  },
  -- transparency
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
  {
    "sontungexpt/sttusline",
    branch = "table_version",
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
      { "nvimtools/hydra.nvim" }
    },
    keys = require("configs.keymap.hydra").git,
    config = function()
      local Hydra = require("hydra")
      Hydra(require("ui.hydra_conf").setup["git"]())
    end
  },
  -- Hydra
  {
    "nvimtools/hydra.nvim",
    lazy = true
  }
}
