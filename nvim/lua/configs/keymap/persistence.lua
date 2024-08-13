return {
  {"<leader>qs", mode = "n", function ()
    require("persistence").load()
  end, desc = "load the session for the current directory"},
  {"<leader>qS", mode = "n", function ()
    require("persistence").select()
  end, desc = "select session to load"},
  {"<leader>ql", mode = "n", function ()
    require("persistence").load({ last = true })
  end, desc = "load the last session"},
  {"<leader>qd", mode = "n", function ()
    require("persistence").stop()
  end, desc = "stop Persistence => session won't be saved on exit"},
}
