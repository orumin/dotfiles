return {
--  {
--    "thinca/vim-splash"
--  },
-- Must have at least
  {
    "nvim-lualine/lualine.nvim",
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
    config = function()
      require("config-local").setup({
        config_files = { ".nvim.lua", ".nvimrc" },
        hashfile = vim.fn.stdpath("data") .. "/config-local",

        autocommands_create = false,
        commands_create = false,
        silent = false,
        lookup_parents = false,
      })
    end
  },
-- color schemes
  {
    'jacoborus/tender.vim'
  },
  {
    'tanvirtin/monokai.nvim'
  },
  {
    'vigoux/oak',
    config = function()
      vim.api.nvim_set_var("oak_virtualtext_bg", "1")
    end
  },
  {
    'rktjmp/lush.nvim'
  },
  {
    'ellisonleao/gruvbox.nvim'
  },
  {
    'ChristianChiarulli/nvcode-color-schemes.vim'
  },
  {
    'sainnhe/sonokai'
  },
-- transparency
  {
    'miyakogi/seiya.vim',
    config = function()
      vim.api.nvim_set_var("seiya_auto_enable", "1")
      vim.api.nvim_set_var("seiya_target_groups", {"ctermbg", "guibg"})
    end
  },
-- ime
  {
    'tyru/eskk.vim',
    config = function()
      vim.o.imdisable = true
      vim.o.iminsert = 0
      vim.api.nvim_set_var("eskk#directory", vim.fn.stdpath("data") .. "/eskk")
      vim.api.nvim_set_var("eskk#dictionary", {
        path = vim.fn.stdpath("data") .. "/eskk/.skk-jisyo",
        sorted = "0",
        encoding = "utf-8",
      })
      vim.api.nvim_set_var("eskk#large_dictionary", {
        path = "/usr/share/skk/SKK-JISYO.L",
        sorted = "1",
        encoding = "euc-jisx0213",
      })
      vim.api.nvim_set_var("eskk#enable_completion", "1")
      vim.api.nvim_set_var("eskk#egg_like_newline", "1")
    end
  },
  {
    'koron/codic-vim'
  },
}

