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
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  -- x86 asm
  {
    "shiracamus/vim-syntax-x86-objdump-d",
    ft = "dis",
  },
}
