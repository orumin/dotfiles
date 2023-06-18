local icons = require("configs.ui.icons").get("ui")

return function ()
  local opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      diagnostics = false,
      numbers = function (opts)
        return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      end,
      sort_by = "insert_at_end",
      buffer_close_icon = icons.Close,
      modified_icon = icons.Circle,
      close_icon = icons.Close_alt,
      left_trunc_marker = icons.Left,
      right_trunc_marker = icons.Right,
      offsets = {
        {
          filetype = "neo-tree",
          text = function ()
            return vim.fn.getcwd()
          end,
          highlight = "Directory",
          text_align = "center",
          padding = 1,
        },
        {
          filetype = "lspsagaoutline",
          text = "Lspsaga Outline",
          text_align = "center",
          padding = 1,
        }
      },
    },
    highlights = {},
  }

  local color = require("core.color")
  if color.name:find("catppuccin") then
    local palette = require("lib").get_palette()
    local catppuccin_hl = {
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
          mocha = {
            hint = { fg = palette.rosewater },
            hint_visible = { fg = palette.rosewater },
            hint_selected = { fg = palette.rosewater },
            hint_diagnostic = { fg = palette.rosewater },
            hint_diagnostic_visible = { fg = palette.rosewater },
            hint_diagnostic_selected = { fg = palette.rosewater },
          }
        }
      })
    }

    vim.tbl_deep_extend("force", opts, catppuccin_hl)
  end

  require("bufferline").setup(opts)
end
