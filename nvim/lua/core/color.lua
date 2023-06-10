vim.api.nvim_set_option('t_Co', '256')

vim.api.nvim_create_augroup("MyColorScheme", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "MyColorScheme",
  pattern = "",
  callback = function()
--    vim.api.nvim_set_hl(0, "Normal", {ctermbg="NONE"})
--    vim.api.nvim_set_hl(0, "NonText", {ctermbg="NONE"})
    vim.api.nvim_set_hl(0, "LineNr", {ctermbg="NONE"})
    vim.api.nvim_set_hl(0, "Folded", {ctermbg="NONE"})
    vim.api.nvim_set_hl(0, "EndOfBuffer", {ctermbg="NONE"})
  end
})

if vim.env.COLORTERM and
  vim.env.COLORTERM == "truecolor" then
  vim.o.termguicolors = true
-- vim.o.guicolors = true
  vim.api.nvim_set_var("nvcode_termcolors", "256")
  vim.cmd([[colorscheme nvcode]])
  -- vim.cmd([[colorscheme oak]])
else
  vim.cmd([[colorscheme tender]])
end

