return {
  ["nvim_lsp"] = require("configs.keymap.nvim-lsp"),
  ["trouble"] = require("configs.keymap.trouble"),
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
    { "<C-t>", ":<c-u>TransToEN<CR>", mode = "v", silent = true, desc = "translate"  }
  },
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>", desc = "windows" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>", desc = "windows" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>", desc = "windows" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>", desc = "windows" },
  },
  ["bufferline"] = require("configs.keymap.bufferline"),
}
