local os = require("os")
local on_attach = function (client, bufnr)
    vim.wo.signcolumn = 'yes'
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gh', '<Cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua require("lspsaga.provider").preview_definition()<CR>', opts)
--    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>', opts)
--    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

--    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--        vim.lsp.diagnostic.on_publish_diagnostics, {
--            virtual_text = false,
--        }
--    )

    dofile(os.getenv("HOME") .. "/.vim/rc/plugins/lua/plugin-lspkind.lua")
    dofile(os.getenv("HOME") .. "/.vim/rc/plugins/lua/plugin-lspsaga.lua")

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
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

local lsp_installer = require("nvim-lsp-installer")
local nvim_lsp = require('lspconfig')

local clangd_root_dir = nvim_lsp.util.root_pattern('build/compile_commands.json', '.git')

nvim_lsp.clangd.setup{on_attach = on_attach, capabilities = capabilities}
nvim_lsp.rust_analyzer.setup{on_attach = on_attach, capabilities = capabilities}

lsp_installer.on_server_ready(function(server)
    local opts = {}
--    local init_options = {}
    if server.name == "clangd" then
--        init_options.compilationDatabasePath = "build"
--        opts.init_options = init_options
        opts.root_dir = clangd_root_dir
    end
    if server.name == 'sumneko_lua' then
        opts.settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
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
    end

    opts.on_attach = on_attach
    opts.capabilities = capabilities
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
