local opts = { mode = "n", buffer = true, silent = true }
local maps = {
  { "gD", "<Cmd>Lspsaga goto_definition<CR>" },
  { "gd", "<Cmd>Lspsaga peek_definition<CR>" },
  { "gh", "<Cmd>Lspsaga lsp_finder<CR>" },
  { "gi", "<Cmd>Lspsaga implement<CR>" },
  { "<C-k>", "<Cmd>Lspsaga hover_doc<CR>" },
  { "<space>wa", vim.lsp.buf.add_workspace_folder, desc = "LSP add workspace folder" },
  { "<space>wr", vim.lsp.buf.remove_workspace_folder, desc = "LSP remove workspace folder" },
  { "<space>wl", function ()
    vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO, {title = "[lsp]"})
  end, desc = "LSP list workspace folders" },
  { "<space>D", "<Cmd>Lspsaga peek_type_definition<CR>" },
  { "<space>rn", "<Cmd>Lspsaga rename<CR>" },
  { "<space>ca", "<Cmd>Lspsaga code_action<CR>", mode = { "n", "v" } },
  { "gr", vim.lsp.buf.references, desc = "LSP references" },
  { "<space>e", "<Cmd>Lspsaga show_line_diagnostics<CR>" },
  { "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" },
  { "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>" },
  { "<leader>ci", "<Cmd>Lspsaga incoming_calls<CR>" },
  { "<leader>co", "<Cmd>Lspsaga outgoing_calls<CR>" },
  { "<leader>lo", "<Cmd>Lspsaga outline<CR>" },
}

for _, v in ipairs(maps) do
  v = vim.tbl_deep_extend("keep", v, opts)
end

return maps
