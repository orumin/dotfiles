return function ()
  local opts = {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
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
