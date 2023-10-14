return {
  textDocument = {
--    implementation = {
--      { "gi", vim.lsp.buf.implementation, mode = "n", silent = true, desc = "LSP implementation" },
--    },
    references = {
      { "gh", "<Cmd>Lspsaga finder<CR>", mode = "n", silent = true, desc = "LSP fuzzy find references" },
      { "gr", vim.lsp.buf.references, mode = "n", silent = true, desc = "LSP references" },
    },
    rename = {
      { "<leader>rpn", "<Cmd>Lspsaga project_replace<CR>", mode = "n", silent = true, desc = "LSP workspace rename" },
      { "<leader>rn", "<Cmd>Lspsaga rename<CR>", mode = "n", silent = true, desc = "LSP rename" },
    },
    definition = {
      { "gD", "<Cmd>Lspsaga goto_definition<CR>", mode = "n", silent = true, desc = "LSP goto_definition" },
      { "gd", "<Cmd>Lspsaga peek_definition<CR>", desc = "LSP peek_definition" },
    },
    typeDefinition = {
      { "<leader>D", "<Cmd>Lspsaga peek_type_definition<CR>", mode = "n", silent = true, desc = "LSP peek_type_definition" },
      { "gs", "<Cmd>Lspsaga goto_type_definition<CR>", mode = "n", silent = true, desc = "LSP goto_type_definition" },
    },
    documentSymbol = {
      { "<leader>go", "<Cmd>Lspsaga outline<CR>", mode ="n", silent = true, desc = "LSP show symbol outline" },
    },
    hover = {
      { "K", vim.lsp.buf.hover, mode = "n", silent = true, desc = "LSP hover document" },
    },
    diagnostic = {
      { "<leader>cd", vim.diagnostic.open_float, mode = "n", silent = true, desc = "LSP line diagnostics" },
      { "[d", vim.diagnostic.goto_prev, mode = "n", silent = true, desc = "LSP previous diagnostic" },
      { "]d", vim.diagnostic.goto_next, mode = "n", silent = true, desc = "LSP next diagnostic" },
      { "[e", function () vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP previous error" },
      { "]e", function () vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP next error" },
    },
    signatureHelp = {
      { "<C-s>", vim.lsp.buf.signature_help, mode = "i", silent = true, desc = "LSP signature help" }
    },
    codeLens = {
      { "<leader>cl", vim.lsp.codelens.run, mode = "n", silent = true, desc = "LSP run CodeLens" }
    },
    codeAction = {
      { "<leader>ca", vim.lsp.buf.code_action, mode = { "n", "v" }, silent = true, desc = "LSP code action" },
    },
  },
  callHierarchy = {
    ncomingCalls = {
      { "<leader>ci", "<Cmd>Lspsaga incoming_calls<CR>", mode ="n", silent = true, desc = "LSP incoming_calls" },
    },
    outgoingCalls = {
      { "<leader>co", "<Cmd>Lspsaga outgoing_calls<CR>", mode ="n", silent = true, desc = "LSP outgoing_calls" },
    },
  },
  workspace = {
    diagnostic = {
      { "<leader>cd", vim.diagnostic.open_float, mode = "n", silent = true, desc = "LSP line diagnostics" },
      { "[d", vim.diagnostic.goto_prev, mode = "n", silent = true, desc = "LSP previous diagnostic" },
      { "]d", vim.diagnostic.goto_next, mode = "n", silent = true, desc = "LSP next diagnostic" },
      { "[e", function () vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP previous error" },
      { "]e", function () vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP next error" },
    },
    workspaceFolders = {
      { "<leader>wa", vim.lsp.buf.add_workspace_folder, mode = "n", silent = true, desc = "LSP add workspace folder" },
      { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "LSP remove workspace folder" },
      { "<leader>wl", function ()
        vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO, {title = "[lsp]"})
      end, mode ="n", silent = true, desc = "LSP list workspace folders" },
    }
  }
}

