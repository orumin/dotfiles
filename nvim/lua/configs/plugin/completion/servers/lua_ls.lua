local opt = {
  settings = {
    Lua = {
      runtime = {
        version = '5.4',
        path = {
          '?.lua',
          '?/init.lua',
        }
      },
      workspace = {
        library = {
          [vim.env.VIMRUNTIME .. "/lua"] = true,
          [vim.env.VIMRUNTIME .. "/lua/vim/lsp"] = true,
          ["${3rd}/luv/library"] = true,
          ["${3rd}/luassert/library"] = true,
        },
      },
    },
  }
}

for _, v in pairs(vim.api.nvim_get_runtime_file('', true)) do
  opt.settings.Lua.workspace.library[v] = true
end

return opt
