local configs = require("configs")
return function()
  local icons = {
    kind = require("configs.ui.icons").get("kind"),
    type = require("configs.ui.icons").get("type"),
    cmp = require("configs.ui.icons").get("cmp"),
  }

  local cmp = require("cmp")
  local luasnip = require( "luasnip")

  local winopts = cmp.config.window.bordered()
  local opts = {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
      format = function(entry, vim_item)
        local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp) or {}
        -- load lspkind icons
        vim_item.kind =
        string.format(" %s %s", lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")

        vim_item.menu = setmetatable({
          cmp_tabnine = icons.cmp.cmp_tabnine .. "[TN]",
          copilot = icons.cmp.copilot .. "[CPLT]",
          buffer = icons.cmp.buffer .. "[BUF]",
          orgmode = icons.cmp.orgmode .. "[ORG]",
          nvim_lsp = icons.cmp.nvim_lsp .. "[LSP]",
          nvim_lua = icons.cmp.nvim_lua .. "[LUA]",
          path = icons.cmp.path .. "[PATH]",
          tmux = icons.cmp.tmux .. "[TMUX]",
          treesitter = icons.cmp.treesitter .. "[TS]",
          luasnip = icons.cmp.luasnip .. "[SNIP]",
          spell = icons.cmp.spell .. "[SPELL]",
          }, {
            __index = function()
              return "[BTN]" -- builtin/unknown source names
            end,
        })[entry.source.name]

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. "..."
        end

        return vim_item
      end,
    },
    window = {
      completion = winopts,
      documentation = winopts
    },
    sources = cmp.config.sources({
      configs.use_skk and {name = "skkeleton"} or {},
      {name = "nvim_lsp", max_item_count = 100 },
      {name = "luasnip", option = { show_autosnippets = true } },
      {name = "luasnip_choice"},
      {name = "buffer"},
      {name = "path"},
      {name = "cmdline_history"},
      {name = "cmdline"},
      {name = "cmp_pandoc"},
    }),
    mapping = cmp.mapping.preset.insert({
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    --view = {
    --  entries = "native",
    --},
  }

  cmp.setup(opts)

  ---@diagnostic disable-next-line: missing-fields
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources(
      {
        { name = "git" },
      },
      {
        { name = "buffer" },
      }
    )
  })

  ---@diagnostic disable-next-line: missing-fields
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = "buffer" },
      },
      {
        { name = "cmdline_history" },
      }

    )
  })

  ---@diagnostic disable-next-line: missing-fields
  cmp.setup.cmdline( ":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = "path" },
      },
      {
        { name = "cmdline_history" },
      },
      {
        { name = "cmdline" },
      }
    )
  })

  ---@diagnostic disable-next-line: missing-fields
  cmp.setup.cmdline( "@", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = "cmdline_history" },
      }
    )
  })

  require("cmp_git").setup()
  require("cmp_pandoc").setup()
  require("cmp_luasnip_choice").setup({
    auto_open = true
  })
end
