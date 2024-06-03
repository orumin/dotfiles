local opts = { mode = "n", buffer = true, silent = true }
local maps = {
  {
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics (Trouble)"
  },
  {
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)"
  },
  {
    "<leader>cL",
    "<cmd>Trouble loclist toggle<cr>",
    desc = "Location List (Trouble)"
  },
  {
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    desc = "Quickfix List (Trouble)"
  },
  {
    "grR",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "LSP Definitions / references / ... (Trouble)"
  },
}

for _, v in ipairs(maps) do
  v = vim.tbl_extend("keep", v, opts)
end

return maps
