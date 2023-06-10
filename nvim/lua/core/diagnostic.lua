local signs = {
  Error = "",
  Warn = "",
  Info = "",
  Hint = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  serverity_sort = true,
  virtual_text = {
    source = true,
  },
})

