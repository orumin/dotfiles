return {
---------------------------------------------------------------
-- built-in LSP server
---------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    init = function ()
      -- disable lsp watcher. Too slow on linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end
    end,
    config = require("completion.nvim-lsp"),
    keys = require("configs.keymap").nvim_lsp
  },
  -- other linter
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = require("completion.servers.null-ls")
  },
  -- pretty good LSP UI
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("completion.lspsaga_conf"),
    config = function(_, opts)
      local ok, catppuccin_kind = pcall(require, "catppuccin.groups.integrations.lsp_saga")
      if ok then
        opts.ui.kind = catppuccin_kind.custom_kind()
      end
      require("lspsaga").setup(opts)
    end
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = require("configs.keymap").trouble,
    opts = require("completion.trouble"),
  },
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
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
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

