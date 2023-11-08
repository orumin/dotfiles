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
    "bashls", "bufls", "clangd", "docker_compose_language_service", "dockerls",
    "gopls", "html", "jsonls", "luau_lsp", "marksman", "powershell_es", "tsserver",
    "lua_ls", "pyright", "texlab", "rust_analyzer", "vimls"
  },
  lsp_disabled_servers = {
--    "ltex"
  },
  dap_default_servers = {
    "bash", "codelldb", "cppdbg", "delve", "python"
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

if not vim.fn.has("win32") == 1 then
  table.insert(settings.lsp_default_servers, "awk_ls")
  table.insert(settings.lsp_default_servers, "cmake")
end

if vim.fn.executable("cargo") == 1 then
  table.insert(settings.lsp_default_servers, "asm_lsp")
  table.insert(settings.lsp_default_servers, "fennel_language_server")
end

if vim.fn.executable("gem") == 1 then
  table.insert(settings.lsp_default_servers, "solargraph")
end

if vim.fn.executable("mvn") == 1 then
  table.insert(settings.lsp_default_servers, "java_language_server")
end

if vim.fn.executable("opam") == 1 then
  table.insert(settings.lsp_default_servers, "ocamllsp")
end

return settings
