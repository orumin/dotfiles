return {
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
      -- lang specific extensions
      "p00f/clangd_extensions.nvim", -- C/C++
      "simrat39/rust-tools.nvim", -- Rust
      { -- other linter
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        },
        config = require("plugins.config.null-ls")
      }
    },
    config = function()
      require("plugins.config.nvim-lsp")
    end
  },
  -- pretty good LSP UI
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("plugins.config.lspsaga")
  },
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = require("plugins.config.trouble"),
    config = function()
      nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
      nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
      nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
      nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
      nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")
    end
  },
-- completion
-- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
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
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
    }
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
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000",
        },
      },
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("plugins.config.noice")
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
    dependencies = {
      "niuiic/niuiic-core.nvim"
    },
    config = function()
      local opts = require("plugins.config.translate_opts")
      require("translate").setup(opts)
      vim.keymap.set("v", "<C-t>", ":<c-u>TransToEN<CR>", {silent = true})
    end
  },
-- Git
  {
    "lewis6991/gitsigns.nvim",
    event = {"FocusLost", "CursorHold"},
    opts = {}
  },
-- filetype plugin
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
    config = function()
      vim.g["tex_flavor"] = "latex"
      if vim.fn.has("mac") == 1 then
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
  -- Asciidoc (w/ asciidoctor)
  {
    "habamax/vim-asciidoctor",
    ft = "asciidoc",
    config = function()
      vim.g["asciidoctor_syntax_conceal"] = 1
      vim.g["asciidoctor_syntax_indented"] = 1
      vim.g["asciidoctor_fenced_languages"] = {"c", "cpp", "rust"}
    end
  },
  -- PlantUML
  {
    "aklt/plantuml-syntax",
    ft = "plantuml",
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
-- Gist
  {
    "lambdalisue/vim-gista",
    cmd = "Gista",
    config = function()
      vim.g["gista#github_user"] = "orumin"
    end
  },
}

