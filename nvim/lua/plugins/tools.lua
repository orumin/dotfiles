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
--      vim.g["eskk#directory"] = nvim_data_dir .. path_sep .. "eskk"
--      vim.g["eskk#dictionary"] = {
--        path = nvim_data_dir .. path_sep .. "eskk" .. path_sep .. ".skk-jisyo",
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
    keys = require("configs.keymap").translate,
    dependencies = {
      "niuiic/niuiic-core.nvim"
    },
    opts = require("tools.translate_opts"),
  },
}

