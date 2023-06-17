return {
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
    build = ":TSUpdate",
    config = function()
      require("ui.treesitter")
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
}

