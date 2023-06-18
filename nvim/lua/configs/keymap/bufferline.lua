local opts = { mode = "n", silent = true }
local maps = {
  { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
  { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
  { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
  { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
  { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
  { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
  { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
  { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
  { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },
  { "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>" },
  { "]b", "<Cmd>BufferLineCycleNext<CR>" },
  { "[b", "<Cmd>BufferLineCyclePrev<CR>" },
}

for _, v in pairs(maps) do
  v = vim.tbl_extend("keep", v, opts)
end

return maps
