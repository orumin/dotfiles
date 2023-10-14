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
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      }
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
    config = require("completion.linter_config"),
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
}

