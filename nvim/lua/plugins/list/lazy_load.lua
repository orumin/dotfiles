local rc_dir = vim.env.XDG_CONFIG_HOME .. "/nvim/rc/plugins"
local opts = {
  -- built-in LSP server
  {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
      "kkharji/lspsaga.nvim",
      "p00f/clangd_extensions.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/mason-lspconfig.nvim",
      "ray-x/lsp_signature.nvim",
    },
    config = function()
      require("plugins.config.nvim-lsp")
    end
  },
  {
    "ray-x/lsp_signature.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
  },
-- C/C++
  {
    "p00f/clangd_extensions.nvim"
  },
-- Rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig"
    },
    config = function()
      require("plugins.config.rust-tools")
    end
  },
-- other linter
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("plugins.config.null-ls")
    end
  },
  {
    "nvim-lua/plenary.nvim"
  },
-- decorate lsp outputs
  {
    "kkharji/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("plugins.config.lspsaga")
    end
  },
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
    "nvim-tree/nvim-web-devicons"
  },
-- color scheme with tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
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
  {
    "p00f/nvim-ts-rainbow",
  },
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
-- grammer checker ( need Java runtime for LanguageTool )
  {
    "rhysd/vim-grammarous",
    ft = {
      "asciidoc", "gitcommit", "gitrebase", "help", "hybrid", "markdown", "pandoc", "rst", "tex", "text", "vcs-commit"
    }
  },
-- translation
  {
    "daisuzu/translategoogle.vim",
    ft = {
      "asciidoc", "gitcommit", "gitrebase", "help", "hybrid", "markdown", "pandoc", "rst", "tex", "text", "vcs-commit"
    },
    cofig = function()
      vim.cmd("source " .. rc_dir .. "/plugin-translategoogle.vim")
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
      vim.cmd("source " .. rc_dir .. "/plugin-vimtex.vim")
    end
  },
-- Asciidoc (w/ asciidoctor)
  {
    "habamax/vim-asciidoctor",
    ft = "asciidoc",
    cofig = function()
      vim.cmd("source " .. rc_dir .. "/plugin-asciidoctor.vim")
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
    cofig = function()
      vim.cmd("source " .. rc_dir .. "/plugin-gista.vim")
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
      vim.cmd("source " .. rc_dir .. "/plugins-vim-pandoc.vim")
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
