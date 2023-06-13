return {
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
          [vim.env.VIMRUNTIME .. "/lua"] = true,
          [vim.env.VIMRUNTIME .. "/lua/vim/lsp"] = true,
        },
      },
    },
  }
}
