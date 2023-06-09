local servers = { "bashls", "clangd", "cmake", "rust_analyzer", "lua_ls", "texlab", "vimls", "pyright", "jsonls" }
require("mason-lspconfig").setup({
    ensure_installed = servers,
})

local lspconfig = require('lspconfig')
local on_attach, capabilities = unpack(require("plugin_settings.nvim-lsp-custom-util"))

for _, server_name in ipairs(servers) do
  if server_name ~= "clangd" or
    server_name ~= "lua_ls" then
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
end

--lspconfig.actionlint.setup{}

local clang_setup_opts = require('plugin_settings.clang_extensions')
local clangd_root_dir = lspconfig.util.root_pattern('build/compile_commands.json', '.git')
--local buf_name = vim.api.nvim_buf_get_name(0)
--local current_buf = vim.api.nvim_get_current_buf()
clang_setup_opts.server = {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = clangd_root_dir
}

require("clangd_extensions").setup(clang_setup_opts)

lspconfig.lua_ls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          version = '5.4',
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    }
}

