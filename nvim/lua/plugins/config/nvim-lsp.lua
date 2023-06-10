local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  vim.notify("error loading nvim-lspconfig")
  return
end
local mason
ok, mason = pcall(require, 'mason')
if not ok then
  vim.notify("error loading mason")
  return
end

local function on_attach(client, _)
 vim.wo.signcolumn = 'yes'

 if client.server_capabilities.documentHighlightProvider then
   vim.api.nvim_create_augroup("MyLspSettings", { clear = true })
   vim.api.nvim_create_autocmd("CursorHold", {
     group = "MyLspSettings",
     pattern = "",
     callback = function()
       vim.lsp.buf.document_highlight()
     end
   })
   vim.api.nvim_create_autocmd("CursorHoldI", {
     group = "MyLspSettings",
     pattern = "",
     callback = function()
       vim.lsp.buf.document_highlight()
     end
   })
   vim.api.nvim_create_autocmd("CursorMoved", {
     group = "MyLspSettings",
     pattern = "",
     callback = function()
       vim.lsp.buf.clear_references()
     end
   })
 end
end

local handlers = {
 -- The first entry (without a key) will be the default handler
 -- and will be called for each installed server that doesn't have
 -- a dedicated handler.
  function(server) -- default
    local opts = {}
    opts.autostart = true
    opts.on_attach = on_attach
    opts.capabilities = require("cmp_nvim_lsp").default_capabilities()
    lspconfig[server].setup(opts)
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["clangd"] = function()
    local clang_setup_opts = require('plugins.config.clang_extensions')
    clang_setup_opts.server.autostart = true
    clang_setup_opts.server.on_attach = on_attach
    clang_setup_opts.server.capabilities = require("cmp_nvim_lsp").default_capabilities()
    clang_setup_opts.server.root_dir = lspconfig.util.root_pattern('build/compile_commands.json', '.git')
    require("clangd_extensions").setup(clang_setup_opts)
  end,
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup({
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
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
          },
        },
      },
    })
  end,
  ["rust_analyzer"] = function()
    local rust_tools_opts = { server = {} }
    rust_tools_opts.server.autostart = true
    rust_tools_opts.server.on_attach = on_attach
    rust_tools_opts.server.capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("rust-tools").setup(rust_tools_opts)
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
  mason_lspconfig.setup_handlers(handlers)
  mason_lspconfig.setup({
    ensure_installed = servers,
    handlers = handlers
  })
end

-- keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
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
    virtual_text = false,
    severity_sort = true,
  }
)

