return {
  textDocument = {
    implementation = {
      { "gI", vim.lsp.buf.implementation, mode = "n", silent = true, desc = "LSP goto implementation" },
      { "gi", function ()
        local lsp = require("core.lsp")
        lsp.peek_implementation()
      end, mode = "n", silent = true, desc = "LSP peek implementation" },
    },
    references = {
      { "gh", function ()
        local builtin = require("telescope.builtin")
        builtin.lsp_references()
      end, mode = "n", silent = true, desc = "LSP fuzzy find references" },
      { "grr", vim.lsp.buf.references, mode = "n", silent = true, desc = "LSP references" },
    },
    rename = {
      --{ "<leader>rpn", "<Cmd>Lspsaga project_replace<CR>", mode = "n", silent = true, desc = "LSP workspace rename" },
      { "grn", vim.lsp.buf.rename, mode = "n", silent = true, desc = "LSP rename" },
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
      { "go", "<Cmd>Outline<CR>", mode ="n", silent = true, desc = "LSP show symbol outline" },
    },
    -- neovim support added icholy/lsplinks.nvim plugin
    documentLink = {
      {"gx", function ()
        local lsplinks = require("lsplinks")
        lsplinks.gx()
      end, mode = "n", silent = true, desc = "LSP document link" },
    },
    hover = {
      { "K", function () vim.lsp.buf.hover({border=require("configs").window_style.border}) end, mode = "n", silent = true, desc = "LSP hover document" },
    },
    diagnostic = {
      { "<C-w>d", vim.diagnostic.open_float, mode = "n", silent = true, desc = "LSP line diagnostics" },
      { "[d", function () vim.diagnostic.jump({count=-1, float=true}) end, mode = "n", silent = true, desc = "LSP previous diagnostic" },
      { "]d", function () vim.diagnostic.jump({count=1, float=true}) end, mode = "n", silent = true, desc = "LSP next diagnostic" },
      { "[e", function () vim.diagnostic.jump({count=-1, float=true, severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP previous error" },
      { "]e", function () vim.diagnostic.jump({count=1, float=true, severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP next error" },
    },
    codeLens = {
      { "grl", vim.lsp.codelens.run, mode = "n", silent = true, desc = "LSP run CodeLens" }
    },
    codeAction = {
      { "gra", vim.lsp.buf.code_action, mode = { "n", "v" }, silent = true, desc = "LSP code action" },
    },
  },
  callHierarchy = {
    incomingCalls = {
--      { "<leader>ci", vim.lsp.buf.incoming_calls, mode ="n", silent = true, desc = "LSP incoming_calls" },
      { "<leader>ci", function ()
        local builtin = require("telescope.builtin")
        builtin.lsp_incoming_calls()
      end, mode ="n", silent = true, desc = "LSP incoming_calls" },
    },
    outgoingCalls = {
--      { "<leader>co", vim.lsp.buf.outgoing_calls, mode ="n", silent = true, desc = "LSP outgoing_calls" },
      { "<leader>co", function ()
        local builtin = require("telescope.builtin")
        builtin.lsp_outgoing_calls()
      end, mode ="n", silent = true, desc = "LSP outgoing_calls" },
    },
  },
  workspace = {
    diagnostic = {
      { "<leader>cd", vim.diagnostic.open_float, mode = "n", silent = true, desc = "LSP line diagnostics" },
      { "[d", function () vim.diagnostic.jump({count=-1, float=true}) end, mode = "n", silent = true, desc = "LSP previous diagnostic" },
      { "]d", function () vim.diagnostic.jump({count=1, float=true}) end, mode = "n", silent = true, desc = "LSP next diagnostic" },
      { "[e", function () vim.diagnostic.jump({count=-1, float=true, severity=vim.diagnostic.severity.ERROR}) end,
        mode = "n", silent = true, desc = "LSP previous error" },
      { "]e", function () vim.diagnostic.jump({count=1, float=true, severity=vim.diagnostic.severity.ERROR}) end,
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

