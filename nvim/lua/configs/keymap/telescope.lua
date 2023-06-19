local opts = { mode = "n", desc = "telescope" }
local maps = {
  { "<leader>ff", "<Cmd>Telescope find_files<CR>" },
  { "<leader>fg", "<Cmd>Telescope live_grep<CR>" },
  { "<leader>fb", "<Cmd>Telescope buffers<CR>" },
  { "<leader>fh", "<Cmd>Telescope help_tags<CR>" },
}

for _, v in ipairs(maps) do
  v = vim.tbl_deep_extend("keep", v, opts)
end

return maps
