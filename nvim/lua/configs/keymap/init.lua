return {
  [1] = {
    {"<ESC><ESC>", function () vim.v.hlsearch = 0 end, mode = "n", desc = "nohlsearch" },
    {"<leader>s", function () vim.o.spell = not vim.o.spell end, mode = "n", desc = "toggle spell"},
    {"<S-c>", "<Cmd>ListcharsToggle<CR>", mode = "n", desc = "toggle display 'tab,space,eol'"},
    {"<leader>di", function () vim.notify(vim.inspect(vim.inspect_pos())) end, mode = "n", desc = "inspect at cursor"},
  },
  ["accelerated_jk"] = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = "n", desc = "accelerated-jk"},
    { "k", "<Plug>(accelerated_jk_gk)", mode = "n", desc = "accelerated-jk"},
  },
  ["gh-addressed"] = {
    {"<leader>gc", "<Cmd>GhReviewComments<CR>", desc = "GitHub Review Comments"},
  },
  ["skkeleton"] = {
    {"<C-j>", "<Plug>(skkeleton-toggle)", mode = {"c", "i"}, desc="skk" }
  },
  ["toggleterm"] = {
    { "tt", "<Cmd>ToggleTerm direction=horizontal<CR>", mode = "n", desc = "open terminal" },
    { "tf", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=float\"<CR>", mode = "n", desc = "open float terminal" },
  },
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>" },
  },
}
