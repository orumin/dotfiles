return {
  {"<leader>sr", function ()
    require("ssr").open()
  end, mode = {"n", "x"}, desc = "structual search & rename" }
}
