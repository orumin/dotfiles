return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      runtime = {
        version = '5.4',
        path = {
          '?.lua',
          '?/init.lua',
        }
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.RUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }
      }
    },
  }
}

