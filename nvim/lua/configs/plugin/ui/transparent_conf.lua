local opts = {
  groups = { -- table: default groups
    "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
    "Statement", "PreProc", "type", "Underlined", "Todo", "String", "Function",
    "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
    "SignColumn", "CursorLineNr", "EndOfBuffer",
  },
  extra_groups = {        -- table: additional groups that should be cleared
    "IblIndent",          -- indent-blankline indent
    "IblWhitespace",      -- indent-blankline indent
    "NormalFloat",        -- plugins with have float panel such as Lazy, Mason, LspInfo
    "NeoTreeNormal",      -- NeoTree
    "NeoTreeNormalNC",    -- NeoTree
    "TroubleNormal"       -- trouble
  },
  exclude_groups = {}, -- table: groups you don't want to clear
  lualine_style = "default",
  --lualine_style = "stealth",
}

return function ()
  local transparent = require("transparent")
  transparent.setup(opts)
  --transparent.clear_prefix("BufferLine")
  transparent.clear_prefix("NeoTree")
  --transparent.clear_prefix("lualine")
end
