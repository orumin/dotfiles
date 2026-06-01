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
    "buf_ls", "marksman",
    "tinymist", "lua_ls", "texlab",
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

---
--- override settings
---

---skkeleton requires deno
---if deno isn't installed, override
if vim.fn.executable("deno") ~= 1 then
  settings.use_denops = false
  settings.use_skk = false
end

if vim.fn.executable("node") ~= 1 then
  settings.use_copilot = false
end

---
--- append lsp servers for default installation
---

if vim.fn.executable("cargo") == 1 then
  table.insert(settings.lsp_default_servers, "asm_lsp")
  table.insert(settings.lsp_default_servers, "fennel_language_server")
  table.insert(settings.lsp_default_servers, "rust_analyzer")
end

if vim.fn.executable("gem") == 1 then
  table.insert(settings.lsp_default_servers, "solargraph")
end

if vim.fn.executable("go") == 1 then
  table.insert(settings.lsp_default_servers, "gopls")
end

if vim.fn.executable("mvn") == 1 then
  table.insert(settings.lsp_default_servers, "java_language_server")
end

if vim.fn.executable("npm") == 1 then
  table.insert(settings.lsp_default_servers, "awk_ls")
  table.insert(settings.lsp_default_servers, "bashls")
  table.insert(settings.lsp_default_servers, "docker_compose_language_service")
  table.insert(settings.lsp_default_servers, "dockerls")
  table.insert(settings.lsp_default_servers, "html")
  table.insert(settings.lsp_default_servers, "jsonls")
  table.insert(settings.lsp_default_servers, "ts_ls")
  table.insert(settings.lsp_default_servers, "pyright")
  table.insert(settings.lsp_default_servers, "vimls")
end

local python_ver_check = function()
  local ret = false
  local handle = io.popen("python3 -V")
  if not handle then
    vim.notify("cannot open pipe", vim.log.levels.ERROR, { title = "[configs] Runtime error" })
    return ret
  end
  local major, minor, patch = handle:read("*a"):match("Python (%d+).(%d+).(%d+)")
  if major == nil or minor == nil or patch == nil then
    vim.notify("failed to retrieve python version", vim.log.levels.WARN, { title = "[configs] Python version" })
    return ret
  end
  if tonumber(minor) >= 14 then
    vim.notify("python minor version is too newer: "..major.."."..minor.."."..patch, vim.log.levels.WARN, { title = "[configs] Python version" })
    goto out
  end

  ret = true
::out::
  handle:close()
  return ret
end

if vim.fn.executable("python3") == 1 then
  if python_ver_check() then
    table.insert(settings.lsp_default_servers, "cmake")
    settings.linters.sql = { "sqlfluff" }
    settings.linters.yaml = { "yamllint" }
  end
end

if vim.fn.executable("opam") == 1 then
  table.insert(settings.lsp_default_servers, "ocamllsp")
end

if vim.fn.has("win32") == 1 or
  vim.fn.executable("unzip") == 1 then
  table.insert(settings.lsp_default_servers, "clangd")
  table.insert(settings.lsp_default_servers, "luau_lsp")
  table.insert(settings.lsp_default_servers, "powershell_es")
end

return settings
