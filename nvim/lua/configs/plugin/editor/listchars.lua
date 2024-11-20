local configs = require("configs")

return function ()
  require("nvim-listchars").setup({
    save_state = false,
    listchars = configs.listchars,
    notifications = false,
    exclude_filetypes = {
      "markdown"
    },
    lighten_step = 10
  })
  local api = require("nvim-listchars.api")
  api.toggle_listchars({"enabled", api.get_highlights()["Whitespace"]["fg"]})
end
