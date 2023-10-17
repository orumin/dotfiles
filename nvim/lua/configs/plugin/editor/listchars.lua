local configs = require("configs")

return function ()
  require("nvim-listchars").setup({
    save_state = false,
    listchars = configs.listchars,
    exclude_filetypes = {
      "markdown"
    },
    lighten_step = 10
  })
  vim.cmd.ListcharsEnable()
end
