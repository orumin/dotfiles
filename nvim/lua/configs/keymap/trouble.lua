local opts = { mode = "n", desc = "trouble", buffer = true, silent = true }
local maps = {
  { "<leader>xx", "<cmd>TroubleToggle<cr>" },
  { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
  { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
  { "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
  { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
  { "gR", "<cmd>TroubleToggle lsp_references<cr>" },
}

for _, v in ipairs(maps) do
  vim.tbl_deep_extend("keep", v, opts)
end

return maps
