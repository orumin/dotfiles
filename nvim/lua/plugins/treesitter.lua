return {
---------------------------------------------------------------
-- tree-sitter
---------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
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
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.cmd([[TSUpdate]])
      end
    end,
    config = require("editor.treesitter"),
  },
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost" },
    main = "ibl",
    config = require("editor.treesitter_addons").indent_blankline,
    cond = false
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
  -- joke with treesitter
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
