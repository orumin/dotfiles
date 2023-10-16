return {
---------------------------------------------------------------
-- built-in LSP server
---------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", lazy = true },
      { "williamboman/mason-lspconfig.nvim", lazy = true },
      { "jay-babu/mason-nvim-dap.nvim", lazy = true },
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
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("lsp.linter_config"),
  },
  -- pretty good LSP UI
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
      { "nvim-telescope/telescope.nvim", lazy = true }
    },
    keys = require("configs.keymap").trouble,
    config = require("lsp.trouble"),
  },
  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("lsp.symbols_outline_conf"),
  },
  {
    "Wansmer/symbol-usage.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("lsp.symbol_usage_conf")
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    event = "LspAttach"
  }
}

