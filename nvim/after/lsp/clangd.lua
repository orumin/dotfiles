local lsputil = require("lspconfig.util")
local clangd_conf = require("configs.plugin.lsp.servers.clangd_conf")

local clangd_opts = clangd_conf.lsp_opts
clangd_opts.root_dir = lsputil.root_pattern('build/compile_commands.json', '.git', 'compile_commands.json')
return clangd_opts
