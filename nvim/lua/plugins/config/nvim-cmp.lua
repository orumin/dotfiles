local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

local formatting = {}
local lspkind, lspkind_opts
ok, lspkind = pcall(require, "lspkind")
if ok then
  ok, lspkind_opts = pcall(require, "plugins.config.lspkind")
  if ok then
    lspkind.init(lspkind_opts)
  end
  formatting = {
    format= lspkind.cmp_format({
      maxwidth = "50",
      ellipsis_char = "...",
      before = function (entry, vim_item)
        return vim_item
      end
    })
  }
end

local opts = {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  formatting = formatting,
  sources = cmp.config.sources({
    {name = "nvim_lsp"},
    {name = "nvim_lsp_signature_help"},
    {name = "vsnip"},
    {name = "buffer"},
    {name = "path"},
    {name = "cmdline"},
  }),
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-l>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  }),
}

cmp.setup(opts)
