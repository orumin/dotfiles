return function ()
  local palette = require("envutils").get_palette()
  local ui = require("configs.ui.icons").get("ui")
  local is_picking_focus = require("cokeline.mappings").is_picking_focus
  local is_picking_close = require("cokeline.mappings").is_picking_close
  local get_hex = require("cokeline.hlgroups").get_hl_attr

  local min_buffer_width = 23

  local components = {
    separator = {
      text = " ",
      bg = get_hex("Normal", "bg"),
      truncation = { priority = 1 }
    },
    space = {
      text = " ",
      truncation = { priority = 1 }
    },
    left_half_circle = {
      text = "",
      fg = get_hex("ColorColumn", "bg"),
      bg = get_hex("Normal", "bg"),
      truncation = { priority = 1 }
    },
    right_half_circle = {
      text = "",
      fg = get_hex("ColorColumn", "bg"),
      bg = get_hex("Normal", "bg"),
      truncation = { priority = 1 }
    },
    devicon = {
      text = function (buf) return buf.devicon.icon end,
      fg = function (buf) return buf.devicon.color end,
      bg = get_hex("ColorColumn", "bg"),
      truncation = { priority = 1 }
    },
    index = {
      text = function (buf)
        return
          (is_picking_focus() or is_picking_close())
          and (buf.pick_letter .. "  ")
          or (buf.index .. ": ")
      end,
      fg = function (buf)
        return
          (is_picking_focus() and palette.yellow)
          or (is_picking_close() and palette.red)
          or (buf.is_focused and get_hex("Normal", "fg"))
          or get_hex("Comment", "fg")
      end,
      bold = function () return is_picking_focus() or is_picking_close() end,
      italic = function () return is_picking_focus() or is_picking_close() end,
      truncation = { priority = 1 }
    },
    unique_prefix = {
      text = function (buf) return buf.unique_prefix end,
      fg = get_hex("Comment", "fg"),
      truncation = {
        priority = 3,
        direction = "left",
      }
    },
    filename = {
      text = function (buf) return buf.filename end,
      italic = function (buf) return buf.is_focused end,
      truncation = {
        priority = 2,
        direction = "left",
      }
    },
    close_or_unsave = {
      text = function (buf)
        return buf.is_modified and ui.Circle or ui.Close
      end,
      fg = function (buf)
        return buf.is_modified and palette.green or get_hex("Normal", "fg")
      end,
      bold = false,
      italic = false,
      delete_buffer_on_left_click = true,
      truncation = { priority = 1 }
    },
  }

  ---@param buf Buffer
  ---@return integer
  local get_remaining_space = function (buf)
    local used_space = 0
    for _, component in pairs(components) do
      used_space = used_space + vim.fn.strwidth(
        ((type(component.text) == "string" and component.text)
        or (type(component.text) == "function" and component.text(buf))--[[@as string]])
      )
    end
    return math.max(0, min_buffer_width - used_space)
  end

  local left_padding = {
    text = function (buf)
      local remaining_space = get_remaining_space(buf)
      return string.rep(" ", remaining_space / 2 + remaining_space % 2)
    end
  }

  local right_padding = {
    text = function (buf)
      local remaining_space = get_remaining_space(buf)
      return string.rep(" ", remaining_space / 2)
    end
  }

  require("cokeline").setup({
    show_if_buffers_are_at_least = 1,
    mappings = {
      cycle_prev_next = true
    },
    default_hl = {
      fg = function (buf)
        return buf.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
      end,
      bg = get_hex("ColorColumn", "bg"),
      bold = function (buf) return buf.is_focused end
    },
    components = {
      components.separator,
      components.left_half_circle,
      components.devicon,
      components.space,
      components.index,
      left_padding,
      components.unique_prefix,
      components.filename,
      components.space,
      components.close_or_unsave,
      right_padding,
      components.right_half_circle
    },
    buffers = {
      filter_visible = function (buf)
        local cwd = vim.fs.normalize(vim.fn.getcwd() --[[@as string]])
        local current_fpath = vim.fs.normalize(vim.api.nvim_buf_get_name(buf.number))
        return not not current_fpath:find(cwd, 0, true)
      end
    },
    sidebar = {
      filetype = { "neo-tree" },
      components = {
        {
          text = "Sidebar",
          bg = function() return get_hex("NeoTreeNormal", "bg") end,
          bold = true
        }
      }
    },
    tabs = {
      components = {
        {
          text = function (tab)
            return " | " .. tab.number .. (tab.is_last and " |" or "")
          end,
          bold = function (tab) return tab.is_focused end,
          fg = function (tab)
            return tab.is_active and get_hex("Normal", "fg") or get_hex("Comment", "fg")
          end,
          bg = get_hex("ColorColumn", "bg"),
        }
      }
    }
  })
end
