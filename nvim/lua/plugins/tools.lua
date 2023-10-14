local palette = require("envutils").get_palette()
local settings = require("configs.global_settings")
return {
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
  -- terminal
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    keys = require("configs.keymap").toggleterm,
    cmd = {
      "ToggleTerm",
      "ToggleTermToggleAll",
      "TermExec",
      "TermSelect",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
      "ToggleTermSetName",
    },
    config = require("tools.toggleterm_conf")
  },
  -- Markdown previewer
  {
    "orumin/glow.nvim",
    lazy = true,
    config = require("tools.glow_conf"),
    cmd = "Glow"
  },
  -- Git
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    config = true
  },
  {
    "rhysd/committia.vim",
  },
  {
    "hotwatermorning/auto-git-diff",
    lazy = true,
    ft = "gitrebase"
  },
  -- diff tool
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
      "DiffviewOpen",
      "DiffviewToogleFile",
      "DiffviewFileHistory",
    },
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
  -- ime
  {
    "vim-skk/skkeleton",
    lazy = false,
    keys = require("configs.keymap").skkeleton,
    cond = vim.fn.has("nvim-0.8") == 1 and settings.use_skk, -- disable
    dependencies = {
      "vim-denops/denops.vim",
      {
        "delphinus/skkeleton_indicator.nvim",
        init = function ()
          vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji", { fg=palette.blue, bg=palette.base, bold=true })
          vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira", { fg=palette.base, bg=palette.green, bold=true })
          vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata", { fg=palette.base, bg=palette.yellow, bold=true})
          vim.api.nvim_set_hl(0, "SkkeletonIndicatorHankaku", { fg=palette.base, bg=palette.pink, bold=true})
          vim.api.nvim_set_hl(0, "SkkeletonIndicatorZenkaku", { fg=palette.base, bg=palette.blue, bold=true})
        end,
        config = true,
      },
    },
    config = require("tools.skkeleton"),
  },
  -- writing table in plain text
  {
    "dhruvasagar/vim-table-mode",
    lazy = true,
    ft = {
      "asciidoc", "gitcommit", "gitrebase", "help", "hybrid", "markdown", "pandoc", "rst", "tex", "text", "vcs-commit"
    },
  },
  -- writing ascii diagram
  {
    "jbyuki/venn.nvim",
    lazy = true,
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
  -- godbolt Compiler Explorer
  {
    "krady21/compiler-explorer.nvim",
    lazy = true,
    cmd = {
      "CECompile",
      "CECompileLive",
      "CEFormat",
      "CEAddLibrary",
      "CELoadExample",
      "CEOpenWebsite",
      "CEDeleteCache",
      "CEShowTooltip",
      "CEGotoLabel"
    }
  },
  -- translation
  {
    "voldikss/vim-translator",
    lazy = true,
    keys = require("configs.keymap").translator,
    config = require("tools.translator"),
    cmd = {
      "Translate",
      "TranslateW",
      "TranslateR",
      "TranslateX",
      "TranslateH",
      "TranslateL",
    }
  },
  -- search nerd font icons
  {
    "2kabhishek/nerdy.nvim",
    lazy = true,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Nerdy",
  },
}

