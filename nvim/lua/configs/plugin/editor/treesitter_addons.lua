local M = {}

function M.hlchunk()
  local configs = require("configs")
  local icons = {
    lines = require("configs.ui.icons").get("lines"),
  }
  local utils = require("envutils")
  local palette = utils.get_palette()
  local opts = {
    blank = {
      enable = true,
      priority = 9,
      chars = { configs.listchars.space },
      style = {
        { bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
        { bg = "", fg = "" },
      },
    },
    chunk = {
      enable = true,
      priority = 15,
      style = {
        { fg = palette.lavender },
        { fg = palette.red },
      },
      use_treesitter = true,
      chars = {
        horizontal_line = icons.lines.Hbar,
        vertical_line = icons.lines.Vbar,
        left_top = icons.lines.RoundedLeftTop,
        left_bottom = icons.lines.RoundedLeftBottom,
        right_arrow = icons.lines.RightArrow,
      },
      textobject = "",
      max_file_size = 1024 * 1024,
      error_sign = true,
    },
    indent = {
      enable = true,
      priority = 10,
      style = { vim.api.nvim_get_hl(0, { name = "Whitespace" }) },
      use_treesitter = false,
      chars = { icons.lines.VbarLeftOffset },
      ahead_lines = 5,
    },
    line_num = {
      enable = true,
      style = palette.lavender,
      priority = 10,
      use_treesitter = false,
    },
  }

  for _, v in pairs(opts) do
    v.exclude_filetypes = {
      aerial = true,
      dashboard = true,
    }
  end

  require("hlchunk").setup(opts)
end

function M.rainbow_delimiters()
  local highlight = require("configs.ui.color").get_rainbow_highlights()
  local rainbow_delimiters = require("rainbow-delimiters")
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
      vim = rainbow_delimiters.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      latex = 'rainbow-blocks',
      lua = 'rainbow-blocks',
    },
    highlight = highlight,
  }
end

return M
