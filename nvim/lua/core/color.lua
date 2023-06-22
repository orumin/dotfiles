local M = {}

if vim.env.COLORTERM and vim.env.COLORTERM == "truecolor" then
  M.truecolor = true
  M.name = "catppuccin"
else
  M.truecolor = false
  M.name = "monokai"
end

function M.settings()
  if M.truecolor then
    vim.o.termguicolors = true
  else
    vim.o.t_Co = "256"
  end

  if gui_running then
    vim.o.guicolors = true
    vim.o.guifont = "PlemolJP Console NF:h13"
  end

  vim.cmd.colorschem(M.name)
end

return M
