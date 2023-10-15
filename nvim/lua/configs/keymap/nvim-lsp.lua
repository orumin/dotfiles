return {
  textDocument = {
    implementation = {
      { "gI", vim.lsp.buf.implementation, mode = "n", silent = true, desc = "LSP implementation" },
    },
    references = {
      { "gh", "<Cmd>Telescope lsp_references<CR>", mode = "n", silent = true, desc = "LSP fuzzy find references" },
      { "gr", vim.lsp.buf.references, mode = "n", silent = true, desc = "LSP references" },
    },
    rename = {
      --{ "<leader>rpn", "<Cmd>Lspsaga project_replace<CR>", mode = "n", silent = true, desc = "LSP workspace rename" },
      { "<leader>rn", vim.lsp.buf.rename, mode = "n", silent = true, desc = "LSP rename" },
    },
    definition = {
      { "gD", vim.lsp.buf.definition, mode = "n", silent = true, desc = "LSP goto_definition" },
      { "gd", function ()
        local lsp = require("core.lsp")
        lsp.peek_definition()
      end, desc = "LSP peek_definition" },
    },
    typeDefinition = {
      { "<leader>D", vim.lsp.buf.declaration, mode = "n", silent = true, desc = "LSP peek_type_definition" },
      { "gsg", vim.lsp.buf.type_definition, mode = "n", silent = true, desc = "LSP goto_type_definition" },
      { "gsp", function ()
        local lsp = require("core.lsp")
        lsp.peek_type_definition()
      end, mode = "n", silent = true, desc = "LSP peek_type_definition" },
    },
    documentSymbol = {
      { "go", "<Cmd>SymbolsOutline<CR>", mode ="n", silent = true, desc = "LSP show symbol outline" },
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
    incomingCalls = {
--      { "<leader>ci", vim.lsp.buf.incoming_calls, mode ="n", silent = true, desc = "LSP incoming_calls" },
      { "<leader>ci", "<Cmd>Telescope lsp_incoming_calls<CR>", mode ="n", silent = true, desc = "LSP incoming_calls" },
    },
    outgoingCalls = {
--      { "<leader>co", vim.lsp.buf.outgoing_calls, mode ="n", silent = true, desc = "LSP outgoing_calls" },
      { "<leader>co", "<Cmd>Telescope lsp_outgoing_calls<CR>", mode ="n", silent = true, desc = "LSP outgoing_calls" },
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

