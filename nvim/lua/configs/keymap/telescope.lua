local maps = {
  { "<leader>ff", "<Cmd>Telescope find_files<CR>", mode = "n", desc = "Telescope find files" },
  { "<leader>fg", "<Cmd>Telescope live_grep<CR>", mode = "n", desc = "Telescope live grep" },
  { "<leader>fb", "<Cmd>Telescope buffers<CR>", mode = "n", desc = "Telescope buffers" },
  { "<leader>fh", "<Cmd>Telescope help_tags<CR>", mode = "n", desc = "Telescope help tags" },
}

return maps
