return {
---------------------------------------------------------------
-- filetype plugin
---------------------------------------------------------------
  -- BitBake
  {
    "kergoth/vim-bitbake",
    ft = "bitbake",
  },
  -- C/C++
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    opts = require("configs.plugin.lsp.servers.clangd_conf").ext_opts
  },
  -- C (qmk firmware)
  {
    "codethread/qmk.nvim",
    -- TODO: restrict load this plugin when open QMK firmware's source code
    ft = { "c", "cpp", "objc", "objcpp" },
    config = require("tools.qmk")
  },
  -- pandoc markdown
  {
    "vim-pandoc/vim-pandoc-syntax",
    ft = "pandoc",
  },
  -- typst
  {
    "kaarmu/typst.vim",
    ft = "typst",
    init = function()
      if vim.fn.executable("tdf") == 1 then
        vim.g.typst_pdf_viewer = "tdf"
      end
    end,
  },
  -- Lua (NeoVim)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "luvit-meta/library",
      },
    },
    dependencies = {
      { "Bilal2453/luvit-meta" },
    }
  },
  { -- optional `vim.uv` typings
    "Bilal2453/luvit-meta",
    event = "VeryLazy"
  },

  -- Rust
  {
    "mrcjkb/rustaceanvim",
    version = '^6',
    ft = "rust",
    init = require("tools.rustaceanvim_conf")
  },
  -- vimdoc
  {
    "OXY2DEV/helpview.nvim",
    lazy = false
  },
  -- x86 asm
  {
    "shiracamus/vim-syntax-x86-objdump-d",
    ft = "dis",
  },
}
