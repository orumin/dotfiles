return {
  ["accelerated_jk"] = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = "n", desc = "accelerated-jk"},
    { "k", "<Plug>(accelerated_jk_gk)", mode = "n", desc = "accelerated-jk"},
  },
  ["bufferline"] = require("configs.keymap.bufferline"),
  ["neotree"] = {
    { "<leader>ft", function ()
      require("neo-tree.command").execute({
        toggle = true,
        dir = require("lib").get_root(),
      })
    end,
    desc = "NeoTree" }
  },
  ["nvim_lsp"] = require("configs.keymap.nvim-lsp"),
  ["skkeleton"] = {
    {"<C-j>", "<Plug>(skkeleton-toggle)", mode = {"c", "i"}, desc="skk"}
  },
  ["telescope"] = require("configs.keymap.telescope"),
  ["translate"] = {
    { "<C-t>", ":<c-u>TransToEN<CR>", mode = "v", silent = true, desc = "translate"  }
  },
  ["trouble"] = require("configs.keymap.trouble"),
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>", desc = "windows" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>", desc = "windows" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "windows" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>", desc = "windows" },
  },

}
