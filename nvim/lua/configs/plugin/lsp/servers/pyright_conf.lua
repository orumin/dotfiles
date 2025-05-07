---@type vim.lsp.Config
local opts = {
  settings = {
    python = {
      venvPath = ".",
      pythonPath = "./.venv/bin/python",
      analysis = {
        extraPaths = {"."}
      }
    },
  }
}

return opts
