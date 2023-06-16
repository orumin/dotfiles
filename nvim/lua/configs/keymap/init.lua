return {
  ["nvim_lsp"] = require("configs.keymap.nvim-lsp"),
  ["neotree"] = {
      { "<leader>ft", function ()
        require("neo-tree.command").execute({
          toggle = true,
          dir = require("lib").get_root(),
        })
      end,
      desc = "NeoTree" }
  },
  ["translate"] = {
    { "<C-t>", ":<c-u>TransToEN<CR>", "v", silent = true }
  },
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>" },
  },
}
