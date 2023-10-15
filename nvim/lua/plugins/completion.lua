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
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "petertriho/cmp-git",
      {
        "aspeddro/cmp-pandoc.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        }
      },
      -- snippets support
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/cmp-luasnip-choice",
      -- skk
      {
        "rinx/cmp-skkeleton",
        dependencies = {
          "vim-skk/skkeleton"
        },
      },
    },
    config = require("completion.nvim-cmp")
  },
}

