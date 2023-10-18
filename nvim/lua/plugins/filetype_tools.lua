return {
---------------------------------------------------------------
-- filetype plugin
---------------------------------------------------------------
  -- Asciidoc (w/ asciidoctor)
  {
    "habamax/vim-asciidoctor",
    lazy = false,
    ft = "asciidoc",
    config = function()
      vim.g["asciidoctor_syntax_conceal"] = 1
      vim.g["asciidoctor_syntax_indented"] = 1
      vim.g["asciidoctor_fenced_languages"] = {"c", "cpp", "rust"}
    end
  },
  -- BitBake
  {
    "kergoth/vim-bitbake",
    lazy = true,
    ft = "bitbake",
  },
  -- C/C++
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    ft = { "c", "cpp", "objc", "objcpp" }
  },
  {
    "vim-pandoc/vim-pandoc-syntax",
    lazy = true,
    ft = "pandoc",
  },
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = "rust",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  -- x86 asm
  {
    "shiracamus/vim-syntax-x86-objdump-d",
    lazy = true,
    ft = "disassembly",
  },
}

