local opts = {
  -- built-in LSP server
  {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
      -- configuration
      {
        "williamboman/mason.nvim",
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
        },
      },
      -- decorate lsp outputs
      "ray-x/lsp_signature.nvim",
      {
        "folke/trouble.nvim",
        dependencies = {
          "nvim-tree/nvim-web-devicons"
        },
        config = function()
          require("plugins.config.trouble")
        end
      },
      {
--        "nvimdev/lspsaga.nvim",
        "kkharji/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
          {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
              "p00f/nvim-ts-rainbow",
            },
            config = function()
              vim.api.nvim_create_autocmd("User", {
                pattern = "LazyUpdate",
                callback = function()
                  vim.cmd("TSUpdate")
                end
              })
              require("plugins.config.treesitter")
            end
          },
        },
        config = function()
          --require("lspsaga").setup({})
          require("plugins.config.lspsaga")
        end

      },
      -- completion
      "hrsh7th/nvim-cmp",
      -- lang specific extensions
      "p00f/clangd_extensions.nvim", -- C/C++
      "simrat39/rust-tools.nvim", -- Rust
      { -- other linter
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        },
        config = function()
          require("plugins.config.null-ls")
        end
      }
    },
    config = function()
      require("plugins.config.nvim-lsp")
    end
  },
-- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
-- vsnip
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
-- dislay icon with lsp completion
      "onsails/lspkind.nvim",
    },
    config = function()
      require("plugins.config.nvim-cmp")
    end
  },

-- tree-sitter
-- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugins.config.indent-blankline")
    end
  },
-- joke with treesitter
  {
    "Eandrju/cellular-automaton.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

--UI
  {
    "nvim-lua/popup.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
-- translation
  {
    "daisuzu/translategoogle.vim",
    ft = {
      "asciidoc", "gitcommit", "gitrebase", "help", "hybrid", "markdown", "pandoc", "rst", "tex", "text", "vcs-commit"
    },
    cofig = function()
      vim.cmd([[
        let g:translategoogle_default_sl = 'ja' " from
        let g:translategoogle_default_tl = 'en' " to
      ]])
    end
  },
-- writing table in plain text
  {
    "dhruvasagar/vim-table-mode",
    ft = {
      "asciidoc", "gitcommit", "gitrebase", "help", "hybrid", "markdown", "pandoc", "rst", "tex", "text", "vcs-commit"
    },
  },
-- TeX
  {
    "lervag/vimtex",
    ft = {
      "plaintex", "tex"
    },
    cofig = function()
      vim.cmd([[
        let g:tex_flavor = 'latex'

        if has("mac")
            let g:vimtex_view_method = 'skim'
        else
            let g:vimtex_view_method = 'general'
            let g:vimtex_view_general_viewer = 'fwdevince'
            let g:vimtex_view_general_options = '@pdf @line @tex'
        endif

        let g:vimtex_compiler_latexmk = {
            \ 'options': [
            \   '-pdfdvi',
            \   '-file-line-error',
            \   '-halt-on-error',
            \   '-interaction=nonstopmode',
            \   '-shell-escape',
            \   '-synctex=1',
            \],
        \}
      ]])
    end
  },
-- Asciidoc (w/ asciidoctor)
  {
    "habamax/vim-asciidoctor",
    ft = "asciidoc",
    cofig = function()
      vim.cmd([[
        "let g:asciidoctor_executable = 'asciidoctor'
        "let g:asciidoctor_extensions = ['asciidoctor-diagram', 'asciidoctor-rouge']
        let g:asciidoctor_syntax_conceal = 1
        let g:asciidoctor_syntax_indented = 1
        let g:asciidoctor_fenced_languages = ['c', 'cpp', 'rust']
      ]])
    end
  },
-- PlantUML
  {
    "aklt/plantuml-syntax",
    ft = "plantuml",
  },
-- Gist
  {
    "lambdalisue/vim-gista",
    cmd = "Gista",
    config = function()
      vim.cmd("let g:gista#github_user = 'orumin'")
    end
  },
-- x86 asm
  {
    "shiracamus/vim-syntax-x86-objdump-d",
    ft = "asm",
  },
-- Pandoc markdown
  {
    "vim-pandoc/vim-pandoc",
    ft = "pandoc",
    config = function()
      vim.cmd("let g:pandoc#modules#disabled = ['chdir']")
    end
  },
  {
    "vim-pandoc/vim-pandoc-syntax",
    ft = "pandoc",
  },
-- BitBake
  {
    "kergoth/vim-bitbake",
    ft = "bitbake",
  },
}

for _, v in ipairs(opts) do
  v["lazy"] = true
end

return opts
