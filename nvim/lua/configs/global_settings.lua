local settings = {
  disabled_rtp_plugins = {
    gzip = true,
    man = nil,
    matchit = true,
    matchparen = true,
    netrwPlugin = true,
    rplugin = true,
    shada = true,
    spellfile = true,
    tarPlugin = true,
    tohtml = true,
    tutor = true,
    zipPlugin = true,
  },
  linters = {
--    lua = { "luacheck" },
    markdown = { "vale" },
--    proto = { "buf", "protolint" },
    proto = { "buf_lint" },
    python = { "mypy" },
    sh = { "shellcheck" },
    sql = { "sqlfluff" },
    yaml = { "yamllint" },
  },
  lsp_default_servers = {
    "clangd", "cmake", "jsonls", "ltex", "lua_ls", "pyright", "rust_analyzer", "vimls"
  },
  icon = {
    nerd_ver = "3",
  },
  remove_trailing_space = true,
  shell = "fish",
  use_skk = false,
  use_denops = false,
}

return settings
