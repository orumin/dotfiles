return function ()
  local utils = require("envutils")
  local palette = utils.get_palette()
  local mode = require("sttusline.components.mode")
  mode.set_config({
    mode_colors = {
      ["STTUSLINE_NORMAL_MODE"]    = { bg = palette.blue,    fg = palette.mantle },
      ["STTUSLINE_INSERT_MODE"]    = { bg = palette.green,   fg = palette.base   },
      ["STTUSLINE_VISUAL_MODE"]    = { bg = palette.mauve,   fg = palette.base   },
      ["STTUSLINE_NTERMINAL_MODE"] = { bg = palette.mauve,   fg = palette.mantle },
      ["STTUSLINE_TERMINAL_MODE"]  = { bg = palette.green,   fg = palette.base   },
      ["STTUSLINE_REPLACE_MODE"]   = { bg = palette.red,     fg = palette.base   },
      ["STTUSLINE_SELECT_MODE"]    = { bg = palette.pink,    fg = palette.base   },
      ["STTUSLINE_COMMAND_MODE"]   = { bg = palette.peach,   fg = palette.base   },
      ["STTUSLINE_CONFIRM_MODE"]   = { bg = palette.yellow,  fg = palette.base   },
    },
    auto_hide_on_vim_resized = true
  })

  local encoding = require("sttusline.components.encoding")
  encoding.set_config {
    ["utf-8"] = "󰉿",
    ["utf-16"] = "󰊀",
    ["utf-32"] = "",
    ["utf-8mb4"] = "󰊂",
    ["utf-16le"] = "󰊃",
    ["utf-16be"] = "󰊄",
  }

  require("sttusline").setup({
    -- statusline_color = "#000000",
    statusline_color = "StatusLine",

    -- | 1 | 2 | 3
    -- recommended: 3
    laststatus = 3,
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
      mode,
      "filename",
      "git-branch",
      "git-diff",
      "%=",
      "diagnostics",
      "lsps-formatters",
      "copilot",
      "indent",
      encoding,
      "pos-cursor",
--      "pos-curosr-progress"
    }
  })
end
