local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

local opts = {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  sources = cmp.config.sources({
    {name = "nvim_lsp"},
    {name = "nvim_lsp_signature_help"},
    {name = "buffer"},
    {name = "path"},
    {name = "nvim_lua"},
    {name = "vsnip"},
    {name = "cmdline"},
    {name = "git"},
  })
}

cmp.setup(opts)
