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
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
          "nvim-tree/nvim-web-devicons",
          {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
              "HiPhish/nvim-ts-rainbow2",
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
      "petertriho/cmp-git",
      {
        "aspeddro/cmp-pandoc.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        }
      },
-- snippets support
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
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
-- todo comments
  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
-- joke with treesitter
  {
    "Eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
-- Debugger Adapter Protocol
  {
    "rcarriga/nvim-dap-ui",
    event = "BufEnter",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
--UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-treesitter/nvim-treesitter",
    },
    cofig = function()
      require("plugins.config.noice")
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function ()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {}
  },
-- translation
  {
    "niuiic/translate.nvim",
    event = "BufEnter",
    cofig = function()
      require("plugins.config.translate")
      vim.keymap.set("v", "<C-t>", ":<c-u>TransToEn<CR>", {silent = true})
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
      vim.api.nvim_set_var("tex_flavor", "latex")
      if vim.fn.has("mac") == 1 then
        vim.api.nvim_set_var("vimtex_view_method", "skim")
      else
        vim.api.nvim_set_var("vimtex_view_method", "general")
        vim.api.nvim_set_var("vimtex_view_general_viewer", "fwdevince")
        vim.api.nvim_set_var("vimtex_view_general_options", "@pdf @line @tex")
      end
      vim.api.nvim_set_var("vimtex_compiler_latexmk", {
        options = {
          "-pdfdvi",
          "-file-line-error",
          "-halt-on-error",
          "-interaction=nonstopmode",
          "-shell-escape",
          "-synctex=1",
        }
      })
    end
  },
-- Asciidoc (w/ asciidoctor)
  {
    "habamax/vim-asciidoctor",
    ft = "asciidoc",
    cofig = function()
      vim.api.nvim_set_var("asciidoctor_syntax_conceal", "1")
      vim.api.nvim_set_var("asciidoctor_syntax_indented", "1")
      vim.api.nvim_set_var("asciidoctor_fenced_languages", {"c", "cpp", "rust"})
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
      vim.api.nvim_set_var("gista#github_user", "orumin")
    end
  },
-- x86 asm
  {
    "shiracamus/vim-syntax-x86-objdump-d",
    ft = "asm",
  },
-- Pandoc markdown
  {
    "aspeddro/pandoc.nvim",
    ft = "pandoc",
    opts = {},
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
