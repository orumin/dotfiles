local os = require("os")
local on_attach = function (client, bufnr)
    vim.wo.signcolumn = 'yes'

    local maps = {
        {'n', 'gh', '<Cmd>lua require("lspsaga.provider").lsp_finder()<CR>'},
        {'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>'},
--        {'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>'},
        {'n', 'gd', '<Cmd>lua require("lspsaga.provider").preview_definition()<CR>'},
--        {'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>'},
        {'n', 'K', '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>'},
        {'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>'},
--        {'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>'},
        {'n', '<C-k>', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>'},
        {'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'},
        {'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'},
        {'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'},
        {'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
--        {'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>'},
        {'n', '<space>rn', '<cmd>lua require("lspsaga.rename").rename()<CR>'},
        {'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>'},
--        {'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
        {'n', '<space>e', '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>'},
--        {'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
--        {'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'},
        {'n', '[d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>'},
        {'n', ']d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>'},
        {'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'}
    }

    for _, map in ipairs(maps) do
        vim.api.nvim_buf_set_keymap(0, map[1], map[2], map[3], {noremap = true})
    end

--    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--        vim.lsp.diagnostic.on_publish_diagnostics, {
--            virtual_text = false,
--            severity_sort = true,
--        }
--    )

--    require("lsp_signature").on_attach({
--        floating_window = false
--    })

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

require("mason-lspconfig").setup({
    ensure_installed = { "bashls", "clangd", "cmake", "rust_analyzer", "sumneko_lua", "texlab", "vimls", "pyright" },
})

local nvim_lsp = require('lspconfig')

local clangd_root_dir = nvim_lsp.util.root_pattern('build/compile_commands.json', '.git')
local buf_name = vim.api.nvim_buf_get_name(0)
local current_buf = vim.api.nvim_get_current_buf()

nvim_lsp.clangd.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = clangd_root_dir
}

nvim_lsp.bashls.setup{on_attach = on_attach, capabilities = capabilities}
nvim_lsp.cmake.setup{on_attach = on_attach, capabilities = capabilities}
nvim_lsp.rust_analyzer.setup{on_attach = on_attach, capabilities = capabilities}
nvim_lsp.vimls.setup{on_attach = on_attach, capabilities = capabilities}
nvim_lsp.pyright.setup{on_attach = on_attach, capabilities = capabilities}
nvim_lsp.texlab.setup{on_attach = on_attach, capabilities = capabilities}

nvim_lsp.sumneko_lua.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
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
}

