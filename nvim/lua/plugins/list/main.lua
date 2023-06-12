return {
--  {
--    "thinca/vim-splash"
--  },
-- Must have at least
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "arkav/lualine-lsp-progress"
    },
    config = function()
      require("plugins.config.lualine")
    end,
  },
  {
    "Shougo/vinarise"
  },
  {
    "editorconfig/editorconfig-vim"
  },
  {
    "klen/nvim-config-local",
    opts = {
      config_files = { ".nvim.lua", ".nvimrc" },
      hashfile = vim.fn.stdpath("data") .. "/config-local",

      autocommands_create = false,
      commands_create = false,
      silent = false,
      lookup_parents = false,
    }
  },
-- color schemes
  {
    "tanvirtin/monokai.nvim"
  },
  {
    "catppuccin/nvim",
    name = "catppuci",
    priority = 1000,
    config = function()
      local ok, catppuccin = pcall(require, "catppuccin")
      if not ok then
        pr_error("error loading catppuccin")
        return
      end
      catppuccin.setup({
        integrations = {
          cmp = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
          gitsigns = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          lsp_saga = true,
          lsp_trouble = true,
          mason = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          noice = true,
          notify = true,
          treesitter = true,
          ts_rainbow2 = true,
        }
      })
    end
  },
-- transparency
  {
    'orumin/ya-seiya.nvim',
    name = "seiya",
    opts = {
      auto_enabled = true,
      target_groups = {"ctermbg"}
--      target_groups = {"ctermbg", "guibg"}
    }
  },
-- ime
  {
    'tyru/eskk.vim',
    config = function()
      vim.o.imdisable = true
      vim.o.iminsert = 0
      vim.g["eskk#directory"] = vim.fn.stdpath("data") .. "/eskk"
      vim.g["eskk#dictionary"] = {
        path = vim.fn.stdpath("data") .. "/eskk/.skk-jisyo",
        sorted = 0,
        encoding = "utf-8",
      }
      vim.g["eskk#large_dictionary"] = {
        path = "/usr/share/skk/SKK-JISYO.L",
        sorted = 1,
        encoding = "euc-jisx0213",
      }
      vim.g["eskk#enable_completion"] = true
      vim.g["eskk#egg_like_newline"] = true
    end
  },
  {
    'koron/codic-vim'
  },
-- Git
  { -- lazy load will not work with this plugin
    "rhysd/committia.vim",
  },
  { -- lazy load will not work with this plugin
    "hotwatermorning/auto-git-diff",
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },
-- other utils
  {
    "dstein64/vim-startuptime"
  }
}

