local settings = {
  mapleader = " ",
  filetypes = {
    extension = {
      bb = "bitbake",
      bbappend ="bitbake",
      bbclass = "bitbake",
      dis = "dis",
      md = "markdown",
      mdwn = "markdown",
      mkd = "markdown",
      mkdn = "markdown",
--      yml = "ansible",
    },
    filename = {
      [".gitignore_global"] = "gitignore",
      ["launch.json"] = "jsonc",
      ["settings.json"] = "jsonc"
    },
    pattern = {
      [".*%.env%..*"] = "env",
      [".*%.mark%.*"] = "markdown"
    }
  },
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
--    proto = { "buf_lint" },
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
    "asm_lsp", "awk_ls", "bashls", "bufls", "clangd", "cmake", "docker_compose_language_service",
    "dockerls", "fennel_language_server", "gopls", "html", "java_language_server", "jsonls",
    "luau_lsp", "marksman", "ocamllsp", "powershell_es", "solargraph", "tsserver",
    "lua_ls", "pyright", "texlab", "rust_analyzer", "vimls"
  },
  lsp_disabled_servers = {
--    "ltex"
  },
  dap_default_servers = {
    "bash", "codelldb", "cppdbg", "delve", "python"
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
  use_skk = true,
  use_denops = false,
}

return settings
