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
  ["bufferline"] = require("configs.keymap.bufferline_keyconf"),
  ["hydra"] = require("configs.keymap.hydra_keyconf"),
  ["neotree"] = {
    { "<leader>nt", function ()
      if package.loaded["neo-tree.command"] == nil then
        local ok, mod = pcall(require, "neo-tree.command")
        if ok then
          package.loaded["neo-tree.command"] = mod
        else
          return
        end
      end
      require("neo-tree.command").execute({
        toggle = true,
        dir = require("envutils").get_root(),
      })
    end,
    desc = "toggle NeoTree" }
  },
  ["nvim_lsp"] = require("configs.keymap.nvim-lsp"),
  ["skkeleton"] = {
    {"<C-j>", "<Plug>(skkeleton-toggle)", mode = {"c", "i"}, desc="skk"}
  },
  ["toggleterm"] = {
    { "vtf", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=float\"<CR>", mode = "n", desc = "open float terminal" },
    { "vts", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=horizontal\"<CR>", mode = "n", desc = "open horizontal terminal" },
    { "vtv", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=vertical\"<CR>", mode = "n", desc = "open vertical terminal" }
  },
  ["translator"] = {
    { "<leader>tt", "<Plug>Translate",   mode = "n", silent = true, desc = "echo translation in the cmdline" },
    { "<leader>tt", "<Plug>TranslateV",  mode = "v", silent = true, desc = "echo translation in the cmdline" },
    { "<leader>tw", "<Plug>TranslateW",  mode = "n", silent = true, desc = "display translation in a window" },
    { "<leader>tw", "<Plug>TranslateWV", mode = "v", silent = true, desc = "display translation in a window" },
    { "<leader>tr", "<Plug>TranslateR",  mode = "n", silent = true, desc = "replace the text with transation" },
    { "<leader>tr", "<Plug>TranslateRV", mode = "v", silent = true, desc = "replace the text with transation" },
    { "<leader>tx", "<Plug>TranslateX",  mode = "n", silent = true, desc = "translate the text in clipboard" },
  },
  ["trouble"] = require("configs.keymap.trouble"),
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>" },
  },
}
