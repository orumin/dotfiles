return {
---------------------------------------------------------------
-- filetype plugin
---------------------------------------------------------------
  -- Asciidoc (w/ asciidoctor)
  {
    "habamax/vim-asciidoctor",
    lazy = true,
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
    ft = { "c", "cpp" }
  },
  -- Pandoc markdown
  {
    "aspeddro/pandoc.nvim",
    lazy = true,
    ft = "pandoc",
    opts = {},
  },
  {
    "vim-pandoc/vim-pandoc-syntax",
    lazy = true,
    ft = "pandoc",
  },
  -- PlantUML
  {
    "aklt/plantuml-syntax",
    lazy = true,
    ft = "plantuml",
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
  -- TeX
  {
    "lervag/vimtex",
    lazy = true,
    ft = {
      "plaintex", "tex"
    },
    config = function()
      vim.g["tex_flavor"] = "latex"
      if is_mac then
        vim.g["vimtex_view_method"] = "skim"
      else
        vim.g["vimtex_view_method"] = "general"
        vim.g["vimtex_view_general_viewer"] = "fwdevince"
        vim.g["vimtex_view_general_options"] = "@pdf @line @tex"
      end
      vim.g["vimtex_compiler_latexmk"] = {
        options = {
          "-pdfdvi",
          "-file-line-error",
          "-halt-on-error",
          "-interaction=nonstopmode",
          "-shell-escape",
          "-synctex=1",
        }
      }
    end
  },
  -- x86 asm
  {
    "shiracamus/vim-syntax-x86-objdump-d",
    lazy = true,
    ft = "asm",
  },
}

