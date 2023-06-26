--vim.api.nvim_set_keymap('', '<C-U>', '<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>', {})
--vim.api.nvim_set_keymap('', '<C-D>', '<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>', {})

nnoremap("<ESC><ESC>", ":nohlsearch<CR><ESC>")
nnoremap("<leader>s",
function ()
  if vim.o.spell then
    vim.o.spell = false
  else
    vim.o.spell = true
  end
end, {desc = "toggle spell"})

-- terminal
nnoremap("vt", "<Cmd>terminal<CR>")
-- display space
nnoremap("<S-c>",
function ()
  local it = vim.iter(vim.opt.listchars:get())
  local space = it:any(function(k,_) return k == "space" end)
  if space then
    vim.opt.listchars:remove("space")
  else
    vim.opt.listchars:prepend("space:⋅")
  end
end, {desc = "toggle display 'space'"})

