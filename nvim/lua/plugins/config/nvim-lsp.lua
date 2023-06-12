local lspconfig = require("lspconfig")
local ok, mason = pcall(require, 'mason')
if not ok then
  pr_error("error loading mason")
  return
end
local cmp_nvim_lsp
ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
  pr_error("error loading cmp_nvim_lsp")
  cmp_nvim_lsp = nil
end

vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

local function on_attach()
 vim.wo.signcolumn = 'yes'
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
if cmp_nvim_lsp ~= nil then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local default_handler =  function(server)
  local opts = {}
  opts.autostart = true
  opts.on_attach = on_attach
  opts.capabilities = capabilities
  lspconfig[server].setup(opts)
end

local handlers = {
 -- The first entry (without a key) will be the default handler
 -- and will be called for each installed server that doesn't have
 -- a dedicated handler.
  [1] = default_handler, -- default
  -- Next, you can provide targeted overrides for specific servers.
  ["clangd"] = function()
    local clangd_extensions
    ok, clangd_extensions = pcall(require, "clangd_extensions")
    if not ok then
      pr_error("error loading clangd_extensions")
      default_handler("clangd")
      return
    end

    local clang_setup_opts = require('plugins.config.clang_extensions')
    clang_setup_opts.server.autostart = true
    clang_setup_opts.server.on_attach = on_attach
    clang_setup_opts.server.capabilities = capabilities
    clang_setup_opts.server.capabilities.offsetEncoding = "utf-8"
    clang_setup_opts.server.root_dir = lspconfig.util.root_pattern('build/compile_commands.json', '.git')
    clang_setup_opts.server.init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    }
    clangd_extensions.setup(clang_setup_opts)
  end,
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      autostart = true,
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
      },
    })
  end,
  ["rust_analyzer"] = function()
    local rust_tools
    ok, rust_tools = pcall(require, "rust-tools")
    if not ok then
      pr_error("error loading rust-tools")
      default_handler("rust_analyzer")
      return
    end

    local rust_tools_opts = { server = {} }
    rust_tools_opts.server.autostart = true
    rust_tools_opts.server.on_attach = on_attach
    rust_tools_opts.server.capabilities = capabilities
    rust_tools.setup(rust_tools_opts)
  end,
}

mason.setup({
  ui = {
    border = 'single',
  },
})

local servers = { "bashls", "clangd", "cmake", "jsonls", "ltex", "lua_ls", "pyright", "rust_analyzer", "vimls", }
local mason_lspconfig
ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok then
  mason_lspconfig.setup({
    ensure_installed = servers,
    handlers = handlers,
  })
  mason_lspconfig.setup_handlers(handlers)
end

vim.api.nvim_create_autocmd("FileType", {
  group = "UserLspConfig",
  pattern = "LspsagaHover",
  callback = function()
    vim.keymap.set("n", "<ESC>", "<cmd>close!<cr>", {buffer=true, silent=true, nowait=true})
  end
})


-- keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = "UserLspConfig",
  callback = function(ev)
    local bufkeymap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, {buffer = ev.buf})
    end

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    bufkeymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
    bufkeymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
    bufkeymap('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
    bufkeymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>')
    bufkeymap('n', 'gx', '<Cmd>Lspsaga code_action<CR>')
    bufkeymap('n', 'gD', vim.lsp.buf.declaration)
    bufkeymap('n', 'gd', '<Cmd>Lspsaga preview_definition<CR>')
    bufkeymap('n', 'lk', '<Cmd>Lspsaga hover_doc<CR>')
    bufkeymap('n', 'gi', '<Cmd>Lspsaga implement<CR>')
    bufkeymap('n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>')
    bufkeymap('n', '<space>rn', '<Cmd>Lspsaga rename<CR>')
    bufkeymap('n', 'gr', vim.lsp.buf.references)
    bufkeymap('n', '<space>e', '<Cmd>Lspsaga show_line_diagnostics<CR>')
    bufkeymap('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
    bufkeymap('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
  end
})

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = true,
    source = true,
  }
)

