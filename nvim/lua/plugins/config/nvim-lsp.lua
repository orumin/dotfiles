local function on_attach (client, bufnr)
    vim.wo.signcolumn = 'yes'

    local keymap = vim.api.nvim_buf_set_keymap
    local maps = {
        {'n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'},
        {'n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'},
        {'n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'},
        {'n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>'},
        {'n', 'gx', '<Cmd>Lspsaga code_action<CR>'},
        {'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>'},
        {'n', 'gd', '<Cmd>Lspsaga preview_definition<CR>'},
        {'n', 'lk', '<Cmd>Lspsaga hover_doc<CR>'},
        {'n', 'gi', '<Cmd>Lspsaga implement<CR>'},
        {'n', '<C-k>', '<Cmd>Lspsaga signature_help<CR>'},
        {'n', '<space>rn', '<Cmd>Lspsaga rename<CR>'},
        {'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>'},
        {'n', '<space>e', '<Cmd>Lspsaga show_line_diagnostics<CR>'},
        {'n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>'},
        {'n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<CR>'},
    }

    for _, map in ipairs(maps) do
        keymap(bufnr, map[1], map[2], map[3], { silent = true, noremap = true })
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            severity_sort = true,
        }
    )

    local completion_provider = client.server_capabilities.completionProvider
    local triggers
    if completion_provider ~= nil then
      triggers = client.server_capabilities.completionProvider.triggerCharacters
    end
    local escaped = {}
    if triggers and #triggers > 0 then
      -- convert lsp triggerCharacters to js regexp
      for _, c in pairs(triggers) do
        local ch_list = {'[', '\\', '^', '$', '.', '|', '?', '*', '+', '(', ')'}
        if vim.tbl_contains(ch_list, c) then
          table.insert(escaped, '\\'..c)
        else table.insert(escaped, c)
        end
      end
      -- override ddc setting of lsp buffer
      vim.fn['ddc#custom#patch_buffer'] {
        sourceOptions = {
          ["nvim-lsp"] = {
            forceCompletionPattern = table.concat(escaped, '|'),
          }
        },
      }
    end

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
        [[
          augroup MyLspSettings
            autocmd!
            autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]],
        false)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = false
capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
capabilities.textDocument.completion.completionItem.labelDetailsSupport = false
capabilities.textDocument.completion.completionItem.deprecatedSupport = false
capabilities.textDocument.completion.completionItem.commitCharactersSupport = false
-- capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
--        'additionalTextEdits',
    }
}

local servers = { "bashls", "clangd", "cmake", "rust_analyzer", "lua_ls", "texlab", "vimls", "pyright", "jsonls" }
require("mason-lspconfig").setup({
    ensure_installed = servers,
})

local lspconfig = require('lspconfig')

for _, server_name in ipairs(servers) do
  if server_name ~= "clangd" or
    server_name ~= "lua_ls" then
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end
end

--lspconfig.actionlint.setup{}

--local clang_setup_opts = require('plugins.clang_extensions')
local clangd_root_dir = lspconfig.util.root_pattern('build/compile_commands.json', '.git')
----local buf_name = vim.api.nvim_buf_get_name(0)
----local current_buf = vim.api.nvim_get_current_buf()
--clang_setup_opts.server = {
--  on_attach = on_attach,
--  capabilities = capabilities,
--  root_dir = clangd_root_dir
--}
--
--require("clangd_extensions").setup(clang_setup_opts)
lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = clangd_root_dir,
})
lspconfig.lua_ls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
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
    }
}

