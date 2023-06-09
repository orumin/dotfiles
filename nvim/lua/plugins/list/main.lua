local rc_dir = vim.env.XDG_CONFIG_HOME .. '/nvim/rc/plugins'
return {
--  {
--    "thinca/vim-splash"
--  },
-- Must have at least
  {
    "Shougo/echodoc.vim",
    config = function()
      vim.cmd('source ' .. rc_dir .. '/plugin-echodoc.vim')
    end,
  },
  {
    "vim-denops/denops.vim"
  },
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
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "MarcWeber/vim-addon-local-vimrc",
    config = function()
      vim.cmd('source ' .. rc_dir .. '/plugin-vim-addon-local-vimrc.vim')
    end
  },
-- color schemes
  {
    'jacoborus/tender.vim'
  },
  {
    'jacoborus/tender.vim'
  },
  {
    'tanvirtin/monokai.nvim'
  },
  {
    'vigoux/oak',
    config = function()
      vim.cmd('let g:oak_virtualtext_bg = 1')
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
      vim.cmd('source ' .. rc_dir .. '/plugin-seiya.vim')
    end
  },
-- ime
  {
    'tyru/eskk.vim',
    config = function()
      vim.cmd('source ' .. rc_dir .. '/plugin-eskk.vim')
    end
  },
  {
    'koron/codic-vim'
  },
}

