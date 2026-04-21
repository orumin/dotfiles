return {
---------------------------------------------------------------
-- tree-sitter
---------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context" },
      {
        "NvChad/nvim-colorizer.lua",
        name = "colorizer",
        config = true,
      }
    },
    build = function ()
      local ts_update = require("nvim-treesitter.install").update({with_sync = true})
      ts_update()
    end,
    config = require("editor.treesitter").config,
  },
  -- parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost" },
    config = require("editor.treesitter_addons").rainbow_delimiters,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- todo comments
  {
    "folke/todo-comments.nvim",
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
