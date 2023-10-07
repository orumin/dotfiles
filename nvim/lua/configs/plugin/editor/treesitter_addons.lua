local util = require("lib")
local palette = util.get_palette()

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local ibl_opts = {
  indent = {
    char = '▏',
    highlight = {"CursorColumn", "Whitespace"}
  },
  whitespace = {
    highlight = {"CursorColumn", "Whitespace"},
    remove_blankline_trail = false,
  },
  scope = {
    char = '▏',
    enabled = true,
    show_start = true,
    show_end = false,
    injected_languages = false,
    highlight = highlight
  }
}

local M = {}

function M.indent_blankline()
  local hooks = require("ibl.hooks")
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
    vim.api.nvim_set_hl(0, highlight[1], {fg=palette.red})
    vim.api.nvim_set_hl(0, highlight[2], {fg=palette.yellow})
    vim.api.nvim_set_hl(0, highlight[3], {fg=palette.blue})
    vim.api.nvim_set_hl(0, highlight[4], {fg=palette.peach})
    vim.api.nvim_set_hl(0, highlight[5], {fg=palette.green})
    vim.api.nvim_set_hl(0, highlight[6], {fg=palette.mauve})
    vim.api.nvim_set_hl(0, highlight[7], {fg=palette.teal})
  end)

  require("ibl").setup(ibl_opts)

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

function M.rainbow_delimiters()
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
