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
  {
    "vim-pandoc/vim-pandoc-syntax",
    ft = "pandoc",
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
