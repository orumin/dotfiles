return function ()
  local utils = require("envutils")
  local G = utils:globals()
  local opts = {
    config_files = { ".nvim.lua", ".nvimrc" },
    hashfile = utils:path_concat({G.nvim_data_dir, "config-local"}),

    autocommands_create = true,
    commands_create = true,
    silent = false,
    lookup_parents = false,
  }
  require("config-local").setup(opts)
end
