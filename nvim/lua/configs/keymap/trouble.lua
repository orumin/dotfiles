local opts = { mode = "n", buffer = true, silent = true }
local maps = {
  { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "toggle Trouble" },
  { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
  { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics" },
  { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble loclist" },
  { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
  { "gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble LSP references" },
}

for _, v in ipairs(maps) do
  vim.tbl_extend("keep", v, opts)
end

return maps
