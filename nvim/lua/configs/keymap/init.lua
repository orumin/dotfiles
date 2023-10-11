return {
  [1] = {
    {"<ESC><ESC>", function () vim.v.hlsearch = 0 end, mode = "n", desc = "nohlsearch" },
    {"<leader>s", function () vim.o.spell = not vim.o.spell end, mode = "n", desc = "toggle spell"},
--    -- terminal
--    {"vt", util.open_float_term, mode = "n", desc = "open terminal with float window"},
--    {"vst", function ()
--      vim.cmd("belowright terminal")
--      vim.api.nvim_win_set_height(0, 25)
--    end, mode = "n", desc = "open terminal belowright"},
    --
    {"<S-c>", function ()
      local it = vim.iter(vim.opt.listchars:get())
      local space = it:any(function (k,_) return k == "space" end)
      if space then
        vim.opt.listchars:remove("space")
      else
        vim.opt.listchars:prepend("space:⋅")
      end
    end, mode = "n", desc = "toggle display 'space'"}
  },
  ["accelerated_jk"] = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = "n", desc = "accelerated-jk"},
    { "k", "<Plug>(accelerated_jk_gk)", mode = "n", desc = "accelerated-jk"},
  },
  ["bufferline"] = require("configs.keymap.bufferline_keyconf"),
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
        dir = require("utils").get_root(),
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
    { "vts", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=horizontal size=25\"<CR>", mode = "n", desc = "open horizontal terminal" },
    { "vtv", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=vertical size=40\"<CR>", mode = "n", desc = "open vertical terminal" }
  },
  ["translate"] = {
    { "<C-t>", "<cmd>TransToEN<CR>", mode = "v", silent = true, desc = "translate" }
  },
  ["trouble"] = require("configs.keymap.trouble"),
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>" },
  },
}
