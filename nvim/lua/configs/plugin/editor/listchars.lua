local settings = require("configs.global_settings")

return function ()
  require("nvim-listchars").setup({
    save_state = false,
    listchars = settings.listchars,
    exclude_filetypes = {
      "markdown"
    },
    lighten_step = 10
  })
  vim.cmd.ListcharsEnable()
end
