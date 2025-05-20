return {
---------------------------------------------------------------
-- built-in LSP server
---------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
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
  {
      "mason-org/mason.nvim",
    cmd = "Mason",
    config = require("lsp.mason_conf"),
  },
  -- other linters
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { "rshkarin/mason-nvim-lint" }
    },
    config = require("lsp.linter_config"),
  },
  -- formatter
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("lsp.formatter_config"),
  },
  -- start/stop LSP servers upon demand;
  -- keeps RAM usage low
  {
    "zeioth/garbage-day.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "neovim/nvim-lspconfig" }
    },

  },
  -- show progress of LSP server
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  -- support document link from textDocument/documentLink
  {
    "icholy/lsplinks.nvim",
    event = "LspAttach",
    opts = {},
  },
  -- get LSP diagnostics and references to quickfix window
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    keys = require("configs.keymap.trouble"),
    config = require("lsp.trouble"),
  },
  -- show symbol outline get from LSP to sidebar
  {
    "hedyhli/outline.nvim",
    event = "LspAttach",
    config = require("lsp.outline_conf"),
  },
  -- display number of references of the symbol above that
  {
    "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = require("lsp.symbol_usage_conf")
  },
  -- show diagnostics at cursor by virtual text with more details
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach"
  }
}
