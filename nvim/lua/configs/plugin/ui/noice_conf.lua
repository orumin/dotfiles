return function ()
  local icons = {
    kind = require("configs.ui.icons").get("kind", true),
    type = require("configs.ui.icons").get("type", true),
    ui = require("configs.ui.icons").get("ui"),
  }

  require("noice").setup({
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = false,
      },
      signature = {
        enabled = false,
        auto_open = {
          enabled = true,
          trigger = true,
          luasnip = true,
          throttle = 50,
        },
        view = nil,
        opts = {},
      },
      message = {
        enabled = true,
        view = "notify",
        opts = {},
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    popupmenu = {
      enabled = true,
      backend = "cmp",
      kind_icons = {
        ["Class"] = icons.kind.Class,
        ["Constant"] = icons.kind.Constant,
        ["Constructor"] = icons.kind.Constructor,
        ["Enum"] = icons.kind.Enum,
        ["EnumMember"] = icons.kind.EnumMember,
        ["Event"] = icons.kind.Event,
        ["Field"] = icons.kind.Field,
        ["File"] = icons.kind.File,
        ["Function"] = icons.kind.Function,
        ["Interface"] = icons.kind.Interface,
        ["Key"] = icons.kind.Keyword,
        ["Method"] = icons.kind.Method,
        ["Module"] = icons.kind.Module,
        ["Namespace"] = icons.kind.Namespace,
        ["Number"] = icons.kind.Number,
        ["Operator"] = icons.kind.Operator,
        ["Package"] = icons.kind.Package,
        ["Property"] = icons.kind.Property,
        ["Struct"] = icons.kind.Struct,
        ["TypeParameter"] = icons.kind.TypeParameter,
        ["Variable"] = icons.kind.Variable,
        -- type
        ["Array"] = icons.type.Array,
        ["Boolean"] = icons.type.Boolean,
        ["Null"] = icons.type.Null,
        ["Object"] = icons.type.Object,
        ["String"] = icons.type.String,
        -- ccls
        ["TypeAlias"] = icons.kind.TypeAlias,
        ["Parameter"] = icons.kind.Parameter,
        ["StaticMethod"] = icons.kind.StaticMethod,
        ["Macro"] = icons.kind.Macro,
        -- for completion sb microsoft!!!
        ["Text"] = icons.kind.Text,
        ["Snippet"] = icons.kind.Snippet,
        ["Folder"] = icons.kind.Folder,
        ["Unit"] = icons.kind.Unit,
        ["Value"] = icons.kind.Value,
      }
    },
  })
end
