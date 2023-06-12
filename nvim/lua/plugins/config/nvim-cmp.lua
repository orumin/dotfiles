local cmp = require("cmp")

local ok, luasnip = pcall(require, "luasnip")
if not ok then
  pr_error("error loading luasnip")
end

local formatting = {}
local lspkind
ok, lspkind = pcall(require, "lspkind")
if ok then
local lspkind_opts = require("plugins.config.lspkind")
  lspkind.init(lspkind_opts)
  formatting = {
    format= lspkind.cmp_format({
      maxwidth = "50",
      ellipsis_char = "...",
      before = function (_, vim_item)
        return vim_item
      end
    })
  }
end

local opts = {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  formatting = formatting,
  sources = cmp.config.sources({
    {name = "nvim_lsp"},
    {name = "luasnip"},
    {name = "buffer"},
    {name = "path"},
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
      { name = "cmdline" },
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

