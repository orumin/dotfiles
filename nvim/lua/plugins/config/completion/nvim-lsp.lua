return function()
  local lspconfig = require("lspconfig")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not ok then
    pr_error("error loading cmp_nvim_lsp")
    cmp_nvim_lsp = nil
  end

  local servers = { "bashls", "clangd", "cmake", "jsonls", "ltex", "lua_ls", "pyright", "rust_analyzer", "vimls", }
  vim.api.nvim_create_augroup("UserLspConfig", { clear = true })

  mason.setup({
    ui = {
      border = 'single',
    },
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if cmp_nvim_lsp ~= nil then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  local opts = {
    autostart = true,
    on_attach = function ()
      vim.wo.signcolumn = true
    end,
    capabilities = capabilities,
  }

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

  ---@param server_name string
  local function mason_handler(server_name)
    local ok, custom_handler = pcall(require, "plugins.config.completion.servers." .. server_name)
    if not ok then
      lspconfig[server_name].setup(opts)
    elseif type(custom_handler) == "function" then
      custom_handler(opts)
    elseif type(custom_handler) == "table" then
      lspconfig[server_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
    else
      pr_error("Failed to setup [" .. server_name .. "]. fix plugins/config/completion/servers/" .. server_name .. ".lua",
        {title = "nvim-lspconfig"})
    end
  end

  mason_lspconfig.setup({
    ensure_installed = servers,
--    handlers = { mason_handler },
  })
  mason_lspconfig.setup_handlers({ mason_handler })
end
