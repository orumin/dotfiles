return {
---------------------------------------------------------------
-- built-in LSP server
---------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", lazy = true },
      { "williamboman/mason.nvim", lazy = true },
      { "williamboman/mason-lspconfig.nvim", lazy = true },
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
      "williamboman/mason.nvim",
    lazy = true,
    cmd = "Mason",
    config = require("lsp.mason_conf"),
  },
  -- other linter
  {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", lazy = true },
      { "rshkarin/mason-nvim-lint", lazy = true }
    },
    config = require("lsp.linter_config"),
  },
  -- start/stop LSP servers upon demand;
  -- keeps RAM usage low
  {
    "hinell/lsp-timeout.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      { "neovim/nvim-lspconfig" }
    },
    init = function()
      local configs = require("configs")
      for k, v in pairs(configs.lsp_timeout) do
        vim.g[k] = v
      end
    end
  },
  -- show progress of LSP server
  {
    "j-hui/fidget.nvim",
    lazy = true,
    tag = "legacy",
    event = "LspAttach",
    config = function ()
      require("fidget").setup({
        window = { relative = "editor", blend = 15 }
      })
    end
  },
  -- get LSP diagnostics and references to quickfix window
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
  -- show symbol outline get from LSP to sidebar
  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("lsp.symbols_outline_conf"),
  },
  -- display number of references of the symbol above that
  {
    "Wansmer/symbol-usage.nvim",
    lazy = true,
    event = "LspAttach",
    config = require("lsp.symbol_usage_conf")
  },
  -- show diagnostics at cursor by virtual text with more details
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    event = "LspAttach"
  }
}

