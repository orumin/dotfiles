local palette = require("envutils").get_palette()
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

local M = {}

function M.set_nvim_cmp_hl()
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

  vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

  vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
  vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

  vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })
end

function M.set_lsp_hl()
  local comment_hl = vim.api.nvim_get_hl(0, {name = "Comment"})
  local cursorline_hl = vim.api.nvim_get_hl(0, {name = "CursorLine"})
  vim.api.nvim_set_hl(0, "LspInlayHint", {
    fg = comment_hl.fg,
    bg = cursorline_hl.bg,
    cterm = comment_hl.cterm,
    italic = comment_hl.italic
  })
end

function M.get_rainbow_highlights()
  return {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
  }
end

function M.set_treesitter_rainbow_hl()
  local highlight = M.get_rainbow_highlights()
  vim.api.nvim_set_hl(0, highlight[1], {fg=palette.red})
  vim.api.nvim_set_hl(0, highlight[2], {fg=palette.yellow})
  vim.api.nvim_set_hl(0, highlight[3], {fg=palette.blue})
  vim.api.nvim_set_hl(0, highlight[4], {fg=palette.peach})
  vim.api.nvim_set_hl(0, highlight[5], {fg=palette.green})
  vim.api.nvim_set_hl(0, highlight[6], {fg=palette.mauve})
  vim.api.nvim_set_hl(0, highlight[7], {fg=palette.teal})
  vim.api.nvim_set_hl(0, "IblIndent",     {bg=palette.mantle})
  vim.api.nvim_set_hl(0, "IblWhitespace", {bg=palette.base})
end

function M.set_symbolusage_hl()
  -- hl-groups can have any name
  vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = h('CursorLine').bg, italic = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = h('CursorLine').bg, fg = h('Comment').fg, italic = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = h('Function').fg, bg = h('CursorLine').bg, italic = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageDef', { fg = h('Type').fg, bg = h('CursorLine').bg, italic = true })
  vim.api.nvim_set_hl(0, 'SymbolUsageImpl', { fg = h('@keyword').fg, bg = h('CursorLine').bg, italic = true })
end

function M.set_skkeleton_indicator_hl()
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji", { fg=palette.blue, bg=palette.base, bold=true })
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira", { fg=palette.base, bg=palette.green, bold=true })
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata", { fg=palette.base, bg=palette.yellow, bold=true})
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorHankaku", { fg=palette.base, bg=palette.pink, bold=true})
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorZenkaku", { fg=palette.base, bg=palette.blue, bold=true})
  vim.api.nvim_set_hl(0, "SkkeletonIndicatorAbbrev", { fg=palette.base, bg=palette.red, bold=true})
end

return M
