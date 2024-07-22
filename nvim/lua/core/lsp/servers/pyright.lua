return function (opts)
  opts = opts or {}

  local pyright_opts = require("configs.plugin.lsp.servers.pyright_conf")
  pyright_opts = vim.tbl_deep_extend("force", {}, opts, pyright_opts) or {}

  require("lspconfig").pyright.setup(pyright_opts)
end
