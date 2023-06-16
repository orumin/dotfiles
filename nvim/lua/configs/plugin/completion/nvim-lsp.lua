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
    on_attach = function (bufnr, _)
      vim.wo.signcolumn = 'yes'
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
    capabilities = capabilities,
  }

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
    local custom_handler
    ok, custom_handler = pcall(require, "completion.servers." .. server_name)
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
