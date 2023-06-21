local settings = require("configs.global_settings")
return function()
  local icons = {
    kind = require("configs.ui.icons").get("kind"),
    type = require("configs.ui.icons").get("type"),
    cmp = require("configs.ui.icons").get("cmp"),
  }

  local cmp = require("cmp")

  local ok, luasnip = pcall(require, "luasnip")
  if not ok then
    pr_error("error loading luasnip")
  end

  local opts = {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    formatting = {
      fields = { "abbr", "kind", "menu" },
			format = function(entry, vim_item)
				local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
				-- load lspkind icons
				vim_item.kind =
					string.format(" %s %s", lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")

				vim_item.menu = setmetatable({
					cmp_tabnine = "[TN]",
					copilot = "[CPLT]",
					buffer = "[BUF]",
					orgmode = "[ORG]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					path = "[PATH]",
					tmux = "[TMUX]",
					treesitter = "[TS]",
					luasnip = "[SNIP]",
					spell = "[SPELL]",
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
    sources = cmp.config.sources({
      settings.use_ssh and {name = "skkeleton"} or {},
      {name = "nvim_lsp", max_item_count = 100 },
      {name = "luasnip"},
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
    view = {
      entries = "native",
    },
  }

  cmp.setup(opts)

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

  cmp.setup.cmdline( "@", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = "cmdline_history" },
      }
    )
  })

  local cmp_pandoc
  ok, cmp_pandoc = pcall(require, "cmp_pandoc")
  if ok then
    cmp_pandoc.setup()
  else
    pr_error("error loading cmp_pandoc")
  end
end
