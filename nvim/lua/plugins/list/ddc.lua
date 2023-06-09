local rc_dir = vim.env.XDG_CONFIG_HOME .. "/nvim/rc/plugins"
return {
-- Complete/Language Server Protocol
  {
    "Shougo/ddc.vim",
    event = {
      "CmdlineEnter", "InsertEnter"
    },
    dependencies = {
      "Shougo/context_filetype.vim",
      "Shougo/ddc-ui-pum",
      "Shougo/neco-vim",
      "Shougo/pum.vim",

      "matsui54/denops-popup-preview.vim",
      "matsui54/denops-signature_help",

      "hrsh7th/vim-vsnip",

      "Shougo/ddc-cmdline",
      "Shougo/ddc-cmdline-history",
      "Shougo/ddc-around",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-converter_remove_overlap",
      "Shougo/ddc-sorter_rank",
      "Shougo/ddc-zsh",
      "Shougo/ddc-nvim-lsp",
      "Shougo/ddc-source-nvim-lsp",
      "tani/ddc-fuzzy",
      "LumaKernel/ddc-file",
      "matsui54/ddc-buffer",
      "matsui54/ddc-dictionary",
      "matsui54/ddc-filter_editdistance",
      "matsui54/ddc-converter_truncate",
      "matsui54/ddc-postfilter_score",
      "matsui54/ddc-ultisnips",
      "gamoutatsumi/ddc-emoji",
      "shun/ddc-vim-lsp",
    },
    config = function()
      vim.cmd("source " .. rc_dir .. "/plugin-ddc.vim")
    end
  },
  {
    "Shougo/pum.vim",
    lazy = true
  },
  {
    "Shougo/ddc-ui-pum",
    lazy = true
  },
  {
    "Shougo/context_filetype.vim",
    event = "BufRead",
    lazy = true
  },
  {
    "Shougo/neco-vim",
    lazy = true
  },
  {
    "Shougo/ddc-cmdline",
  },
  {
    "Shougo/ddc-cmdline-history",
  },
  {
    "Shougo/ddc-around"
  },
  {
    "Shougo/ddc-matcher_head"
  },
  {
    "Shougo/ddc-converter_remove_overlap",
  },
  {
    "Shougo/ddc-sorter_rank",
  },
  {
    "Shougo/ddc-zsh",
  },
  {
    "Shougo/ddc-nvim-lsp",
  },
  {
    "Shougo/ddc-source-nvim-lsp",
  },
  {
    "tani/ddc-fuzzy",
  },
  {
    "LumaKernel/ddc-file",
  },
  {
    "matsui54/ddc-buffer",
  },
  {
    "matsui54/ddc-dictionary",
  },
  {
    "matsui54/ddc-filter_editdistance",
  },
  {
    "matsui54/ddc-converter_truncate",
  },
  {
    "matsui54/ddc-postfilter_score",
  },
  {
    "matsui54/ddc-ultisnips",
  },
  {
    "gamoutatsumi/ddc-emoji",
  },
  {
    "shun/ddc-vim-lsp",
  },
  {
    "matsui54/denops-popup-preview.vim",
    lazy = true,
    config = function()
      vim.cmd("source " .. rc_dir .. "/plugin-denops-popup-preview.vim")
    end
  },
  {
    "matsui54/denops-signature_help",
    lazy = true,
    config = function()
      vim.cmd("source " .. rc_dir .. "/plugin-denops-signature_help.vim")
    end
  },
-- Text snippet
  {
    "hrsh7th/vim-vsnip",
    lazy = true,
    dependencies = {
      "hrsh7th/vim-vsnip-integ",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      vim.cmd("source " .. rc_dir .. "/plugin-vim-vsnip.vim")
    end
  },
  {
    "hrsh7th/vim-vsnip-integ",
  },
  {
    "rafamadriz/friendly-snippets",
  }
}
