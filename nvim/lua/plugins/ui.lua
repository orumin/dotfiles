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
    "nvim-lualine/lualine.nvim",
    event = { "BufEnter" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = require("ui.lualine_config"),
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
      { "cathyprime/hydra.nvim" }
    },
    keys = require("configs.keymap.hydra").git,
    config = function()
      require("gitsigns").setup()
      local Hydra = require("hydra")
      Hydra(require("ui.hydra_conf").setup["git"]())
    end
  },
  -- Hydra
  {
    "cathyprime/hydra.nvim",
    lazy = true
  }
}
