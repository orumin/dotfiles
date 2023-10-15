local icons = require("configs.ui.icons").get("ui")

return function ()
  local bufferline = require("bufferline")
  local opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      diagnostics = false,
      numbers = "ordinal",
      sort_by = "insert_at_end",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      middle_mouse_command = nil,
      indicator = {
        style = "underline"
      },
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
          filetype = "Outline",
          text = "LSP symbols outline",
          text_align = "center",
          padding = 1,
        }
      },
      custom_filter = function (bufnr)
        local cwd = vim.fs.normalize(vim.fn.getcwd())
        local current_fpath = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
        return not not current_fpath:find(cwd, 0, true)
      end,
      buffer_close_icon = icons.Close,
      modified_icon = icons.Circle,
      close_icon = icons.Close_alt,
      left_trunc_marker = icons.Left,
      right_trunc_marker = icons.Right,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,

    },
    highlights = {},
  }

  local color = require("core.color")
  if color.name:find("catppuccin") then
    local palette = require("envutils").get_palette()
    local catppuccin_hl = {
      ---@diagnostic disable-next-line: different-requires
      highlights = require("catppuccin.groups.integrations.bufferline").get({
        styles = { "italic", "bold" },
        custom = {
          all = {
            fill = { bg = "#000000" },
          },
          mocha = {
            background = { fg = palette.txt }
          },
          latte = {
            background = { fg = "#000000" }
          }
        }
      })
    }

    vim.tbl_deep_extend("force", opts, catppuccin_hl)
  end

  bufferline.setup(opts)
end
