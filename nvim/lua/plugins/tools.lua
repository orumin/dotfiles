return {
---------------------------------------------------------------
-- Tools
---------------------------------------------------------------
  -- auto correct
  {
    "https://git.sr.ht/~swaits/thethethe.nvim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = true
  },
  -- edit with sudo
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
    config = function()
      vim.g["suda#prompt"] = "Enter administrator password: "
    end
  },
  -- terminal
  {
    "akinsho/toggleterm.nvim",
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
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    ft = "markdown",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("render-markdown").setup({})
    end
  },
  {
    "orumin/glow.nvim",
    config = require("tools.glow_conf"),
    cmd = "Glow"
  },
  -- cmake-tools
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun" },
    config = require("tools.cmake_tools_conf")
  },
  -- run test
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    }
  },
  -- show coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    cmd = { "CoverageLoad", "CoverageClear" },
    config = require("tools.coverage_conf")
  },
  -- Git
  {
    "NeogitOrg/neogit",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    cmd = "Neogit",
    config = true
  },
  {
    "rhysd/committia.vim",
    ft = "gitcommit"
  },
  {
    "hotwatermorning/auto-git-diff",
    ft = "gitrebase"
  },
  -- diff tool
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewToogleFile",
      "DiffviewFileHistory",
    },
  },
  -- Gist
  {
    "lambdalisue/vim-gista",
    cmd = "Gista",
    config = function()
      vim.g["gista#github_user"] = "orumin"
    end
  },
  -- show GitHub PR comment through folke/trouble.nvim
  {
    "dlvhdr/gh-addressed.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "MunifTanjim/nui.nvim" },
      { "folke/trouble.nvim" }
    },
    cmd = "GhReviewComments",
    keys = require("configs.keymap")["gh-addressed"],
  },
  -- ime
  {
    "vim-skk/skkeleton",
    event = { "InsertEnter", "CmdlineEnter" },
    cond = vim.fn.has("nvim-0.8") == 1 and require("configs").use_skk, -- disable
    dependencies = {
      { "vim-denops/denops.vim" },
      { "yuki-yano/denops-lazy.nvim" },
    },
    config = require("tools.skkeleton"),
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    init = require("configs.ui.color").set_skkeleton_indicator_hl(),
    config = true,
  },
  -- writing table in plain text
  {
    "mattn/vim-maketable",
    cmd = { "MakeTable", "UnmakeTable" }
  },
  -- writing ascii diagram
  {
    "jbyuki/venn.nvim",
    cmd = "VBox",
    dependencies = {
      { "nvimtools/hydra.nvim" }
    },
    keys = require("configs.keymap.hydra").venn,
    config = function ()
      local Hydra = require("hydra")
      Hydra(require("ui.hydra_conf").setup["venn"]())
    end
  },
  -- measure startup time
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- binary edit in vim
  --{
  --  "Shougo/vinarise",
  --  cmd = "Vinarise",
  --},
  {
    "RaafatTurki/hex.nvim",
    cmd = {
      "HexDump",
      "HexAssemble",
      "HexToggle",
    },
    config = true,
  },
  -- godbolt Compiler Explorer
  {
    "krady21/compiler-explorer.nvim",
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
    "potamides/pantran.nvim",
    keys = require("configs.keymap.pantran"),
    cmd = "Pantran",
    config = require("tools.pantran_conf"),
  },
  -- search nerd font icons
  {
    "2kabhishek/nerdy.nvim",
    dependencies = {
      { "stevearc/dressing.nvim" },
      { "nvim-telescope/telescope.nvim" }
    },
    cmd = "Nerdy",
  },
  -- pmodoro timer
--  {
--    "orumin/pomodoro.nvim",
--    cmd = {
--      "PomodoroStart",
--      "PomodoroStatus",
--      "PomodoroStop",
--    },
--    dependencies = {
--      { "MunifTanjim/nui.nvim" }
--    },
--    config = true,
--  },
  {
    "ttak0422/piccolo-pomodoro.nvim",
    keys = require("configs.keymap.pomodoro"),
    config = require("tools.pomodoro_conf"),
  },
  -- profiler
  {
    "stevearc/profile.nvim",
    keys = require("configs.keymap.profile"),
    cond = false
  }
}
