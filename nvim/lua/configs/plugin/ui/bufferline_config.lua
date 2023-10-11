local icons = require("configs.ui.icons").get("ui")

return function ()
  local bufferline = require("bufferline")
  local opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      diagnostics = false,
      numbers = function (opts)
        return string.format('%s %s', opts.raise(opts.id), opts.lower(opts.ordinal))
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
      custom_filter = function (bufnr)
        local cwd = vim.fs.normalize(vim.fn.getcwd())
        local current_fpath = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
        return not not current_fpath:find(cwd, 0, true)
      end,
    },
    highlights = {},
  }

  local color = require("core.color")
  if color.name:find("catppuccin") then
    local palette = require("utils").get_palette()
    local catppuccin_hl = {
      ---@diagnostic disable-next-line: different-requires
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

  bufferline.setup(opts)
end
