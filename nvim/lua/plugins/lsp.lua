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
      "jay-babu/mason-nvim-dap.nvim",
      {
        "simrat39/symbols-outline.nvim",
        config = require("lsp.symbols_outline_conf")
      },
      {
        "Wansmer/symbol-usage.nvim",
        config = require("lsp.symbol_usage_conf")
      },
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
    config = require("core.lsp").setup_handlers,
  },
  -- other linter
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = "VeryLazy",
    config = require("lsp.linter_config"),
  },
  -- pretty good LSP UI
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    keys = require("configs.keymap").trouble,
    opts = require("lsp.trouble"),
  },
}

