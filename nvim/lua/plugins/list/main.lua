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
--  {
--    "MarcWeber/vim-addon-local-vimrc",
--    config = function()
--      vim.cmd("let g:local_vimrc = {'names':['.vimrc.lua'], 'hash_fun':'LVRHashOfFile'}")
--    end
--  },
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
      vim.cmd([[
        let g:seiya_auto_enable = 1
        let g:seiya_target_groups = ['guibg']
      ]])
    end
  },
-- ime
  {
    'tyru/eskk.vim',
    config = function()
      vim.cmd([[
        set imdisable
        set iminsert=0
        let g:eskk#directory = "$HOME/.eskk"
        let g:eskk#dictionary = { 'path' : "$HOME/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
        let g:eskk#large_dictionary = { 'path': "$HOME/.vim/dict/skk/SKK-JISYO.XXL", 'sorted': 1, 'encoding': 'euc-jisx0213', }
        let g:eskk#enable_completion = 1
        let g:eskk#egg_like_newline = 1
      ]])
    end
  },
  {
    'koron/codic-vim'
  },
}

