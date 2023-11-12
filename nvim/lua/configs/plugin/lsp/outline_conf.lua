return function ()
  local icons = {
    kind = require("configs.ui.icons").get("kind"),
    type = require("configs.ui.icons").get("type"),
    ui = require("configs.ui.icons").get("ui"),
  }
  local opts = {
    symbol_folding = {
      markers = { icons.ui.ArrowClosed, icons.ui.ArrowOpen },
    },
    preview_window = {
      auto_preview = false,
      open_hover_on_preview = true,
      border = "rounded",
      winhl = "",
      winblend = 30,
    },
    keymaps = { -- These keymaps can be a string or a table for multiple keys
      show_help = "?",
      close = {"<Esc>", "q"},
      goto_location = "<Cr>",
      peek_location = "o",
      goto_and_close = "<S-Cr>",
      restore_location = "<C-g>",
      hover_symbol = "<C-space>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_toggle = "<Tab>",
      fold_toggle_all = "<S-Tab>",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
      down_and_goto = "<C-j>",
      up_and_goto = "<C-k>"
    },
    providers = {
      lsp = {
        blacklist_clients = {},
      }
    },
    symbols = {
      blacklist = {},
      icons = {
        File = { icon = icons.kind.File, hl = "@text.uri" },
        Module = { icon = icons.kind.Module, hl = "@namespace" },
        Namespace = { icon = icons.kind.Namespace, hl = "@namespace" },
        Package = { icon = icons.kind.Package, hl = "@namespace" },
        Class = { icon = icons.kind.Class, hl = "@type" },
        Method = { icon = icons.kind.Method, hl = "@method" },
        Property = { icon = icons.kind.Property, hl = "@method" },
        Field = { icon = icons.kind.Field, hl = "@field" },
        Constructor = { icon = icons.kind.Constructor, hl = "@constructor" },
        Enum = { icon = icons.kind.Enum, hl = "@type" },
        Interface = { icon = icons.kind.Interface, hl = "@type" },
        Function = { icon = icons.kind.Function, hl = "@function" },
        Variable = { icon = icons.kind.Variable, hl = "@constant" },
        Constant = { icon = icons.kind.Constant, hl = "@constant" },
        String = { icon = icons.type.String, hl = "@string" },
        Number = { icon = icons.type.Number, hl = "@number" },
        Boolean = { icon = icons.type.Boolean, hl = "@boolean" },
        Array = { icon = icons.type.Array, hl = "@constant" },
        Object = { icon = icons.type.Object, hl = "@type" },
        Key = { icon = icons.kind.Keyword, hl = "@type" },
        Null = { icon = icons.type.Null, hl = "@type" },
        EnumMember = { icon = icons.kind.EnumMember, hl = "@field" },
        Struct = { icon = icons.kind.Struct, hl = "@type" },
        Event = { icon = icons.kind.Event, hl = "@type" },
        Operator = { icon = icons.kind.Operator, hl = "@operator" },
        TypeParameter = { icon = icons.kind.TypeParameter, hl = "@parameter" },
        Component = { icon = icons.kind.Component, hl = "@function" },
        Fragment = { icon = icons.kind.Fragment, hl = "@constant" },
        -- Added ccls symbols
        TypeAlias = { icon = icons.kind.TypeAlias, hl = "@type" },
        Parameter = { icon = icons.kind.Parameter, hl = "@parameter" },
        StaticMethod = { icon = icons.kind.StaticMethod, hl = "@function" },
        Macro = { icon = icons.kind.Macro, hl = "@macro" },
      }
    },
  }
  require("outline").setup(opts)
end
