local diagnostic_icons = require("configs.ui.icons").get("diagnostics")
local signs = {
  Error = diagnostic_icons.Error,
  Warn = diagnostic_icons.Warning,
  Info = diagnostic_icons.Information,
  Hint = diagnostic_icons.Hint_alt,
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

