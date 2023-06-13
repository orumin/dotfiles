return {
---------------------------------------------------------------
-- built-in LSP server
---------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      -- configuration
      {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
    },
    config = require("plugins.config.completion.nvim-lsp")
  },
  -- other linter
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = require("plugins.config.completion.servers.null-ls")
  },
  -- pretty good LSP UI
  {
    "nvimdev/lspsaga.nvim",
    lazy = true,
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = require("plugins.config.completion.lspsaga")
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = require("plugins.config.completion.trouble"),
    config = function()
      nnoremap("<leader>xx", "<cmd>TroubleToggle<cr>")
      nnoremap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
      nnoremap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
      nnoremap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
      nnoremap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
      nnoremap("gR", "<cmd>TroubleToggle lsp_references<cr>")
    end
  },
---------------------------------------------------------------
-- completion
---------------------------------------------------------------
  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
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
    config = require("plugins.config.completion.nvim-cmp")
  },
---------------------------------------------------------------
-- tree-sitter
---------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "HiPhish/nvim-ts-rainbow2",
      {
        "NvChad/nvim-colorizer.lua",
        name = "colorizer",
        opts = {}
      }
    },
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyUpdate",
        callback = function()
          vim.cmd("TSUpdate")
        end
      })
      require("plugins.config.ui.treesitter")
    end
  },
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPost" },
    init = function ()
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", {fg="#E06C75", nocombine=true})
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", {fg="#E5C07B", nocombine=true})
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", {fg="#98C379", nocombine=true})
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", {fg="#56B6C2", nocombine=true})
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", {fg="#61AFEF", nocombine=true})
    end,
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = true,
--      char_highlight_list = {
--        "IndentBlanklineIndent1", "IndentBlanklineIndent2", "IndentBlanklineIndent3",
--        "IndentBlanklineIndent4", "IndentBlanklineIndent5", "IndentBlanklineIndent6"
--      },
    }
  },
  -- todo comments
  {
    "folke/todo-comments.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- joke with treesitter
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
---------------------------------------------------------------
-- Debugger Adapter Protocol
---------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate"
    },
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        opts = {}
      },
    },
  },
---------------------------------------------------------------
--UI
---------------------------------------------------------------
  {
    "thinca/vim-splash",
    lazy = true,
    event = { "BufWinEnter" },
    cond = false,
    optional = true,
  },
  -- color schemes
  {
    "tanvirtin/monokai.nvim"
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = require("plugins.config.ui.catppuccin"),
  },
  -- transparency
  {
    'orumin/ya-seiya.nvim',
    lazy = true,
    event = { "BufWinEnter" },
    name = "seiya",
    opts = {
      auto_enabled = true,
      target_groups = {"ctermbg"}
--      target_groups = {"ctermbg", "guibg"}
    }
  },
  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "folke/noice.nvim",
    lazy = true,
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
    opts = require("plugins.config.ui.noice")
  },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = require("plugins.config.ui.lualine")
  },
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    event = "BufReadPost",
    opts = {}
  },
  {
    "dstein64/nvim-scrollview",
    lazy = true,
    event = "BufReadPost",
    opts = {}
  },
  -- cheetsheet
  {
    "folke/which-key.nvim",
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    init = function ()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {}
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = {"FocusLost", "CursorHold"},
    opts = {}
  },
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
---------------------------------------------------------------
-- Tools
---------------------------------------------------------------
  -- edit with sudo
  {
    "lambdalisue/suda.vim",
    lazy = true,
    cmd = { "SudaRead", "SudaWrite" },
    config = function()
      vim.g["suda#prompt"] = "Enter administrator password: "
    end
  },
  -- Git
  {
    "rhysd/committia.vim",
  },
  {
    "hotwatermorning/auto-git-diff",
    lazy = true,
    ft = "gitrebase"
  },
  -- Gist
  {
    "lambdalisue/vim-gista",
    lazy = true,
    cmd = "Gista",
    config = function()
      vim.g["gista#github_user"] = "orumin"
    end
  },
---- ime
--  {
--    'tyru/eskk.vim',
--    config = function()
--      vim.o.imdisable = true
--      vim.o.iminsert = 0
--      vim.g["eskk#directory"] = vim.fn.stdpath("data") .. "/eskk"
--      vim.g["eskk#dictionary"] = {
--        path = vim.fn.stdpath("data") .. "/eskk/.skk-jisyo",
--        sorted = 0,
--        encoding = "utf-8",
--      }
--      vim.g["eskk#large_dictionary"] = {
--        path = "/usr/share/skk/SKK-JISYO.L",
--        sorted = 1,
--        encoding = "euc-jisx0213",
--      }
--      vim.g["eskk#enable_completion"] = true
--      vim.g["eskk#egg_like_newline"] = true
--    end
--  },
  -- writing table in plain text
  {
    "dhruvasagar/vim-table-mode",
    lazy = true,
    ft = {
      "asciidoc", "gitcommit", "gitrebase", "help", "hybrid", "markdown", "pandoc", "rst", "tex", "text", "vcs-commit"
    },
  },
  -- measure startup time
  {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- binary edit in vim
  {
    "Shougo/vinarise",
    lazy = true,
    cmd = "Vinarise",
  },
  -- translation
  {
    "niuiic/translate.nvim",
    lazy = true,
    cmd = "TransToEN",
    dependencies = {
      "niuiic/niuiic-core.nvim"
    },
    config = function()
      local opts = require("plugins.config.tools.translate_opts")
      require("translate").setup(opts)
      vim.keymap.set("v", "<C-t>", ":<c-u>TransToEN<CR>", {silent = true})
    end
  },
  -- project local setting
  {
    "klen/nvim-config-local",
    opts = {
      config_files = { ".nvim.lua", ".nvimrc" },
      hashfile = vim.fn.stdpath("data") .. "/config-local",

      autocommands_create = false,
      commands_create = false,
      silent = false,
      lookup_parents = false,
    }
  },
  { "nvim-lua/plenary.nvim" },
}

