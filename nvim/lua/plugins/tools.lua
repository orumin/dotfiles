local palette = require("envutils").get_palette()
local configs = require("configs")
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
  -- cmake-tools
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true }
    },
    cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun" },
    config = require("tools.cmake_tools_conf")
  },
  -- run test
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    }
  },
  -- show coverage
  {
    "andythigpen/nvim-coverage",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true }
    },
    cmd = { "CoverageLoad", "CoverageClear" },
    config = require("tools.coverage_conf")
  },
  -- Git
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    cmd = "Neogit",
    config = true
  },
  {
    "rhysd/committia.vim",
    lazy = true,
    ft = "gitcommit"
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
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    cond = vim.fn.has("nvim-0.8") == 1 and configs.use_skk, -- disable
    dependencies = {
      { "vim-denops/denops.vim", lazy = true },
      { "yuki-yano/denops-lazy.nvim", lazy = true },
    },
    config = require("tools.skkeleton"),
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    init = require("configs.ui.color").set_skkeleton_indicator_hl(),
    config = true,
  },
  -- writing table in plain text
  {
    "mattn/vim-maketable",
    lazy = true,
    cmd = { "MakeTable", "UnmakeTable" }
  },
  -- writing ascii diagram
  {
    "jbyuki/venn.nvim",
    lazy = true,
    cmd = "VBox",
    dependencies = {
      { "anuvyklack/hydra.nvim", lazy = true }
    },
    keys = require("configs.keymap").hydra["venn"],
    config = function ()
      local Hydra = require("hydra")
      Hydra(require("ui.hydra_conf").setup["venn"]())
    end
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
    "potamides/pantran.nvim",
    lazy = true,
    keys = require("configs.keymap").pantran,
    cmd = "Pantran",
    config = require("tools.pantran_conf"),
  },
  -- search nerd font icons
  {
    "2kabhishek/nerdy.nvim",
    lazy = true,
    dependencies = {
      { "stevearc/dressing.nvim", lazy = true },
      { "nvim-telescope/telescope.nvim", lazy = true }
    },
    cmd = "Nerdy",
  },
  -- pmodoro timer
--  {
--    "orumin/pomodoro.nvim",
--    lazy = true,
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
    lazy = true,
    keys = require("configs.keymap").pomodoro,
    config = require("tools.pomodoro_conf"),
  },
  -- profiler
  {
    "stevearc/profile.nvim",
    lazy = true,
    keys = require("configs.keymap").profile
  }
}

