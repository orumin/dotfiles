local palette = require("lib").get_palette()
local diagnostic_icons = require("configs.ui.icons").get("diagnostics", true)
local _, auto_session_lib = pcall(require, "auto-session.lib")
return {
  options = {
    icons_enabled = true,
    theme = "auto",
    globalstatus = true,
    --component_separators = { left = '', right = ''},
    --section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
        { 'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_lsp' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = {
              error = diagnostic_icons.Error,
              warn = diagnostic_icons.Warning,
              info = diagnostic_icons.Information,
              hint = diagnostic_icons.Hint,
            },
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
        },
    },
    lualine_c = {'filename', auto_session_lib and auto_session_lib.current_session_name },
    lualine_x = {
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updated,
        color = { fg = palette.peach },
      },
      'encoding', 'fileformat', 'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_c = {'filename'},
    lualine_x = {'location'},
  },
}
