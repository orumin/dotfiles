return {
---------------------------------------------------------------
-- tree-sitter
---------------------------------------------------------------
  {
    "romus204/tree-sitter-manager.nvim",
    branch = "main",
    event = { "BufReadPost" },
    cmd = { "TSManager" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-context" },
      {
        "NvChad/nvim-colorizer.lua",
        name = "colorizer",
        config = true,
      }
    },
    config = require("editor.treesitter").config,
  },
  -- parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost" },
    config = require("editor.treesitter_addons").rainbow_delimiters,
    dependencies = {
      "romus204/tree-sitter-manager.nvim",
    },
  },
  -- todo comments
  {
    "folke/todo-comments.nvim",
    event = { "CursorHold", "CursorHoldI" },
    dependencies = {
      "romus204/tree-sitter-manager.nvim",
    },
  },
}
