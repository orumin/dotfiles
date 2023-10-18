local settings = {
  mapleader = " ",
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
  listchars = {
    trail = "-",
    tab = "▸ ",
    space = "⋅",
    eol = "↲",
    extends = "❯",
    precedes = "❮"
  },
  lsp_timeout = {
    stopTimeout  = 1000 * 60 * 5, -- ms, timeout before stopping all LSP servers
    startTimeout = 1000 * 10,     -- ms, timeout before restart
    silent       = false
  },
  lsp_default_servers = {
    "clangd", "cmake", "jsonls", "lua_ls", "pyright", "texlab", "rust_analyzer", "vimls"
  },
  lsp_disabled_servers = {
--    "ltex"
  },
  icon = {
    nerd_ver = "3",
  },
  window_style = {
    border = "rounded",
    winblend = 15
  },
  remove_trailing_space = true,
  shell = "fish",
  use_skk = false,
  use_denops = false,
}

return settings
