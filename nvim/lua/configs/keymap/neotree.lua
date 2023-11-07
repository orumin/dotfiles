return {
  { "<leader>nt", function ()
    require("neo-tree.command").execute({
      toggle = true,
      dir = require("envutils").get_root(),
    })
  end,
    desc = "toggle NeoTree" }
}
