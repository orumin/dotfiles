local icons = {
  kind = require("configs.ui.icons").get("kind", true),
  type = require("configs.ui.icons").get("type", true),
  ui = require("configs.ui.icons").get("ui"),
}
local opts = {
  callhierarchy = {
    layout = 'float'
  },
  hover = {
    max_width = 2.0,
  },
  symbol_in_winbar = {
    enable = true,
    separator = " " .. icons.ui.Separator,
    show_file = true,
    color_mode = true,
  },
  code_action = {
    extend_gitsigns = true,
  },
  lightbulb = {
    sign = false,
  },
  ui = {
    theme = "round",
    border = "rounded",
    winblend = 30,
    title = true,
    actionfix = icons.ui.Spell,
    expand = icons.ui.ArrowClosed,
    cllapse = icons.ui.ArrowOpen,
    code_action = icons.ui.CodeAction,
    incoming = icons.ui.Incoming,
    outgoing = icons.ui.Outgoing,
    kind = {
      ["Class"] = { icons.kind.Class, "Include" },
      ["Constant"] = { icons.kind.Constant, "Constant" },
      ["Constructor"] = { icons.kind.Constructor, "@constructor" },
      ["Enum"] = { icons.kind.Enum, "@number" },
      ["EnumMember"] = { icons.kind.EnumMember, "Number" },
      ["Event"] = { icons.kind.Event, "Constant" },
      ["Field"] = { icons.kind.Field, "@field" },
      ["File"] = { icons.kind.File, "Tag" },
      ["Function"] = { icons.kind.Function, "Function" },
      ["Interface"] = { icons.kind.Interface, "Type" },
      ["Key"] = { icons.kind.Keyword, "Constant" },
      ["Method"] = { icons.kind.Method, "Function" },
      ["Module"] = { icons.kind.Module, "Exception" },
      ["Namespace"] = { icons.kind.Namespace, "Include" },
      ["Number"] = { icons.kind.Number, "Number"  },
      ["Operator"] = { icons.kind.Operator, "Operator" },
      ["Package"] = { icons.kind.Package, "Label" },
      ["Property"] = { icons.kind.Property, "@property" },
      ["Struct"] = { icons.kind.Struct, "Type" },
      ["TypeParameter"] = { icons.kind.TypeParameter, "Type" },
      ["Variable"] = { icons.kind.Variable, "@variable" },
      -- type
      ["Array"] = { icons.type.Array, "Type" },
      ["Boolean"] = { icons.type.Boolean, "Boolean" },
      ["Null"] = { icons.type.Null, "Constant" },
      ["Object"] = { icons.type.Object, "Type" },
      ["String"] = { icons.type.String, "String" },
      -- ccls
      ["TypeAlias"] = { icons.kind.TypeAlias, "Type" },
      ["Parameter"] = { icons.kind.Parameter, "@parameter" },
      ["StaticMethod"] = { icons.kind.StaticMethod, "Function" },
      ["Macro"] = { icons.kind.Macro, "Macro" },
      -- for completion sb microsoft!!!
      ["Text"] = { icons.kind.Text, "String" },
      ["Snippet"] = { icons.kind.Snippet, "@variable" },
      ["Folder"] = { icons.kind.Folder, "Title" },
      ["Unit"] = { icons.kind.Unit, "Number" },
      ["Value"] = { icons.kind.Value, "@variable" },
    }
  }
}

return opts
