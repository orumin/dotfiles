local M = {}

function M.indent_blankline()
  local highlight = require("configs.ui.color").get_rainbow_highlights()
  local ibl_opts = {
    indent = {
      char = '▏',
      highlight = {"IblIndent", "IblWhitespace"},
    },
    whitespace = {
      highlight = {"IblIndent", "IblWhitespace"},
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

  local hooks = require("ibl.hooks")
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
  end)

  require("configs.ui.color").set_treesitter_rainbow_hl()

  require("ibl").setup(ibl_opts)

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
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
