return {
  { "<leader>f", function() require("snacks.picker").pickers() end,
    mode = "n", silent = true, desc = "Pick a buffer to focus" },
}
