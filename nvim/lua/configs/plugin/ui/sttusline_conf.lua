return function ()
  local icons = {
    misc = require("configs.ui.icons").get("misc")
  }
  local utils = require("envutils")
  local G = utils:globals()
  local palette = utils.get_palette()

  local mode_component = require("sttusline.components.mode")
  mode_component.configs.mode_colors = {
    ["STTUSLINE_NORMAL_MODE"]    = { bg = palette.blue,    fg = palette.mantle },
    ["STTUSLINE_INSERT_MODE"]    = { bg = palette.green,   fg = palette.base   },
    ["STTUSLINE_VISUAL_MODE"]    = { bg = palette.mauve,   fg = palette.base   },
    ["STTUSLINE_NTERMINAL_MODE"] = { bg = palette.mauve,   fg = palette.mantle },
    ["STTUSLINE_TERMINAL_MODE"]  = { bg = palette.green,   fg = palette.base   },
    ["STTUSLINE_REPLACE_MODE"]   = { bg = palette.red,     fg = palette.base   },
    ["STTUSLINE_SELECT_MODE"]    = { bg = palette.pink,    fg = palette.base   },
    ["STTUSLINE_COMMAND_MODE"]   = { bg = palette.peach,   fg = palette.base   },
    ["STTUSLINE_CONFIRM_MODE"]   = { bg = palette.yellow,  fg = palette.base   },
  }
  mode_component.update = function(configs)
    local sysicon = (icons.misc[vim.uv.os_uname().sysname] or "")
    local mode_code = vim.api.nvim_get_mode().mode
    local mode = configs.modes[mode_code]
    if mode then return { { sysicon .. " " ..  mode[1], configs.mode_colors[mode[2]] } } end
    return " " .. mode_code .. " "
  end

  local encoding = require("sttusline.components.encoding")
  encoding.configs = {
    ["utf-8"] = "󰉿",
    ["utf-16"] = "󰊀",
    ["utf-32"] = "",
    ["utf-8mb4"] = "󰊂",
    ["utf-16le"] = "󰊃",
    ["utf-16be"] = "󰊄",
  }
  encoding.colors = { fg = palette.yellow }
  encoding.update = function (configs)
    local enc = vim.bo.fenc ~= "" and vim.bo.fenc or vim.o.enc
    return (configs[enc] or enc or "") .. " " .. icons.misc.Vbar .. (vim.bo.ff or "")
  end

  require("sttusline").setup({
    on_attach = function (create_update_group) end,
    -- statusline_color = "#000000",
    statusline_color = "StatusLine",
    disabled = {
      filetypes = {
        -- "NeoTree",
        -- "lazy",
      },
      buftypes = {
        -- "terminal"
      }
    },
    components = {
      mode_component,
      --"filename",
      "git-branch",
      "git-diff",
      "%=",
      "diagnostics",
      "lsps-formatters",
      "copilot",
      "copilot-loading",
      "indent",
      encoding,
      "filesize",
      "pos-cursor",
      "pos-cursor-progress"
    }
  })
end
