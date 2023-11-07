return {
  {"<leader>tr", mode = {"n", "x"}, function ()
    require("pantran").motion_translate()
  end, noremap = true, silent = true, expr = true, desc = "translate"},
  {"<leader>trr", mode = "n", function ()
    return require("pantran").motion_translate() .. "_"
  end, noremap = true, silent = true, expr = true, desc = "translate"},
}
