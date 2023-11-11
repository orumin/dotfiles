local maps = {
  { "]b", "<Plug>(cokeline-focus-next)", mode = "n", silent = true },
  { "[b", "<Plug>(cokeline-focus-prev)", mode = "n", silent = true },
  { "<leader>bpf", function ()
    require("cokeline.mappings").pick("focus")
  end, mode = "n", silent = true, desc = "Pick a buffer to focus" },
  { "<leader>bpc", function ()
    require("cokeline.mappings").pick("close")
  end, mode = "n", silent = true, desc = "Pick a buffer to close" }
}

for i = 1, 9 do
  table.insert(maps,
{ ("<leader>%s"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), mode = "n", silent = true }
  )
end

return maps
