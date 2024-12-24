local configs = require("configs")
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
        Copilot = icons.cmp.copilot,

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
    sources = {
      default = { "lsp", "path", "snippets", "buffer", configs.use_copilot and "copilot" or nil },
      providers = {
        copilot = configs.use_copilot and {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 100,
          async = true,
          transform_items = function (_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        } or nil
      },
    },
    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before *and* after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = 'full' },

      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = false } },

      -- Insert completion item on selection, don't select by default
      -- list = { selection = 'auto_insert' },
      -- or set per mode
      list = { selection = function(ctx) return ctx.mode == 'cmdline' and 'auto_insert' or 'preselect' end },

      menu = {
        auto_show = true,
        border = configs.window_style.border,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      },
    },

    signature = { enabled = true },
  }

  require("blink.cmp").setup(opts)

end
