vim.api.nvim_set_keymap('', '<C-U>', '<C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>', {})
vim.api.nvim_set_keymap('', '<C-D>', '<C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>', {})
vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohlsearch<CR><ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':set spell!<CR>', {noremap = true, silent = true})
