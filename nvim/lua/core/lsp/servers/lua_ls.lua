return function (opts)
  opts = opts or {}

  local luals_opts = require("configs.plugin.lsp.servers.lua_ls_conf")
  luals_opts = vim.tbl_deep_extend("force", {}, opts, luals_opts) or {}

  require("lspconfig").lua_ls.setup(luals_opts)
end
