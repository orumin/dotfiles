return function (opts)
  local utils = require("envutils")
  local G = utils:globals()
  opts = opts or {}

  -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
  local ok, neodev = pcall(require, "neodev")
  if ok then
    neodev.setup({
      override = function(root_dir, library)
        if root_dir:find(utils:path_concat({G.homedir, "dotfiles"}), 1, true) == 1 then
          library.enabled = true
          library.runtime = true
          library.types = true
          library.plugins = true
        end
      end,
      lspconfig = true,
      pathStrict = true
    }) -- for debug NeoVim Lua API
  end

  local luals_opts = require("configs.plugin.lsp.servers.lua_ls_conf")
  luals_opts = vim.tbl_deep_extend("force", {}, opts, luals_opts) or {}

  require("lspconfig").lua_ls.setup(luals_opts)
end
