return function()
  local configs = require("configs")
  require("configs.ui.color").set_nvim_cmp_hl()
  local icons = {
    kind = require("configs.ui.icons").get("kind"),
    type = require("configs.ui.icons").get("type"),
    cmp = require("configs.ui.icons").get("cmp"),
  }

  local cmp = require("cmp")
  local luasnip = require( "luasnip")

  local snippet_expand, snippet_jumpable, snippet_jump
  if vim.snippet then
    snippet_expand = vim.snippet.expand
    snippet_jumpable = vim.snippet.jumpable
    snippet_jump = vim.snippet.jump
  else
    snippet_expand = luasnip.lsp_expand
    snippet_jumpable = luasnip.jumpable
    snippet_jump = luasnip.jump
  end

  local opts = {
    snippet = {
      expand = function(args)
        snippet_expand(args.body)
      end
    },
    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBoard:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        winhighlight = "Normal:Pmenu,FloatBoard:Pmenu,Search:None",
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu"},
      format = function(entry, vim_item)
        local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp) or {}
        local kind_text = vim_item.kind
        -- load lspkind icons
        vim_item.kind = " " .. (lspkind_icons[vim_item.kind] or icons.cmp.undefined) .. " "

        local menu_item = setmetatable({
          cmp_tabnine = icons.cmp.cmp_tabnine .. " [TN]",
          copilot = icons.cmp.copilot .. " [CPLT]",
          buffer = icons.cmp.buffer .. " [BUF]",
          orgmode = icons.cmp.orgmode .. " [ORG]",
          nvim_lsp = icons.cmp.nvim_lsp .. " [LSP]",
          nvim_lua = icons.cmp.nvim_lua .. " [LUA]",
          path = icons.cmp.path .. " [PATH]",
          tmux = icons.cmp.tmux .. " [TMUX]",
          treesitter = icons.cmp.treesitter .. " [TS]",
          luasnip = icons.cmp.luasnip .. " [SNIP]",
          spell = icons.cmp.spell .. " [SPELL]",
          }, {
            __index = function()
              return " [BLTIN]" -- builtin/unknown source names
            end,
        })[entry.source.name]

        vim_item.menu = "   (" .. (kind_text or "") .. ")    " .. menu_item

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. "..."
        end

        return vim_item
      end,
    },
    sources = cmp.config.sources({
      configs.use_skk and {name = "skkeleton"} or {},
      {name = "nvim_lsp", max_item_count = 100 },
      {name = "nvim_lsp_signature_help"},
      {name = "luasnip", option = { show_autosnippets = true } },
      {name = "luasnip_choice"},
      configs.use_copilot and {name = "copilot"} or {},
      {name = "buffer"},
      {name = "path"},
      {name = "cmdline_history"},
      {name = "cmdline"},
      {
        name = "look",
        keyword_length = 2,
        option = {
          convert_case = true,
          loud = true,
          -- dict = "/usr/share/dict/words"
        }
      },
      {name = "cmp_pandoc"},
      {name = "latex_symbols"},
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
        elseif snippet_jumpable(1) then
            snippet_jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.mapping.select_prev_item()
        elseif snippet_jumpable(-1) then
          snippet_jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
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
        { name = "nvim_lsp_document_symbol" },
      },
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
