return function()
  require("configs.ui.color").set_nvim_cmp_hl()
  local icons = {
    kind = require("configs.ui.icons").get("kind"),
    type = require("configs.ui.icons").get("type"),
    cmp = require("configs.ui.icons").get("cmp"),
  }

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  local opts = {
    keymap = { preset = "default" },
    appearance = {
      highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
      kind_icons = {
        Text = icons.kind.Text,
        Method = icons.kind.Method,
        Function = icons.kind.Method,
        Constructor = icons.kind.Constructor,

        Field = icons.kind.Field,
        Variable = icons.kind.Variable,
        Property = icons.kind.Property,

        Class = icons.kind.Class,
        Interface = icons.kind.Interface,
        Struct = icons.kind.Struct,
        Module = icons.kind.Module,

        Unit = icons.kind.Unit,
        Value = icons.kind.Value,
        Enum = icons.kind.Enum,
        EnumMember = icons.kind.EnumMember,

        Keyword = icons.kind.Keyword,
        Constant = icons.kind.Constant,

        Snippet = icons.kind.Snippet,
        Color = icons.kind.Color,
        File = icons.kind.File,
        Reference = icons.kind.Reference,
        Folder = icons.kind.Folder,
        Event = icons.kind.Event,
        Operator = icons.kind.Operator,
        TypeParameter = icons.kind.TypeParameter,
      },
    },
    ---@diagnostic disable-next-line: missing-fields
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    ---@diagnostic disable-next-line: missing-fields
    signature = { enabled = true },
    window = {
      winhighlight = "Normal:Pmenu,FloatBoard:Pmenu,Search:None",

    },
  }

  require("blink.cmp").setup(opts)

end
