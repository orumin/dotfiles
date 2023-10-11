local utils = require("utils")
local termcolor = require("configs.ui.termcolor")
local G = utils.globals()
local M = {}

if G.gui_running or (vim.env.COLORTERM and vim.env.COLORTERM == "truecolor") then
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

  if G.gui_running then
    --vim.o.guicolors = true
    vim.o.guifont = "PlemolJP Console NF:h9"
  end

  for k, v in pairs(termcolor) do
    vim.g[k] = v
  end

  vim.cmd.colorschem(M.name)
end

return M
