return function ()
  local augroup = vim.api.nvim_create_augroup("toggleTermConf", {clear = true})
  vim.api.nvim_create_autocmd("TermEnter", {
    group = augroup,
    pattern = "term://*toggleterm#*",
    callback = function ()
      local winnr = vim.api.nvim_get_current_win()
      vim.wo[winnr].winblend = 30
    end
  })
  require("toggleterm").setup()
end
