return {
---------------------------------------------------------------
-- completion
---------------------------------------------------------------
  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp", lazy = true },
      { "hrsh7th/cmp-buffer", lazy = true },
      { "hrsh7th/cmp-path", lazy = true },
      { "hrsh7th/cmp-cmdline", lazy = true },
      { "dmitmel/cmp-cmdline-history", lazy = true },
      { "petertriho/cmp-git", lazy = true },
      {
        "aspeddro/cmp-pandoc.nvim",
        lazy = true,
        dependencies = {
          { "nvim-lua/plenary.nvim", lazy = true }
        }
      },
      -- snippets support
      { "L3MON4D3/LuaSnip", lazy = true },
      { "saadparwaiz1/cmp_luasnip", lazy = true },
      { "L3MON4D3/cmp-luasnip-choice", lazy = true },
      -- skk
      {
        "rinx/cmp-skkeleton",
        lazy = true,
        dependencies = {
          { "vim-skk/skkeleton", lazy = true }
        },
      },
    },
    config = require("completion.nvim-cmp")
  },
}

