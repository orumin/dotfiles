local settings = {
  mapleader = " ",
  filetypes = {
    extension = {
      adoc = "asciidoc",
      bb = "bitbake",
      bbappend ="bitbake",
      bbclass = "bitbake",
      dis = "dis",
      iuml = "plantuml",
      md = "markdown",
      mdwn = "markdown",
      mkd = "markdown",
      mkdn = "markdown",
      plantuml = "plantuml",
      pu = "plantuml",
      puml = "plantuml",
      uml = "plantuml",
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
    shada = nil,
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
  lsp_default_servers = {
    "bashls", "buf_ls", "clangd", "docker_compose_language_service", "dockerls",
    "gopls", "html", "jsonls", "luau_lsp", "marksman", "powershell_es", "ts_ls",
    "tinymist", "lua_ls", "pyright", "texlab", "rust_analyzer", "vimls"
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
  shell = "nu",
  use_copilot = false,
  use_denops = false,
  use_skk = true,
  use_ttene = false,
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
