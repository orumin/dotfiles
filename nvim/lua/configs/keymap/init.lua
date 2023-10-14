local function toggle_venn()
  local winnr = vim.api.nvim_get_current_win()
  local bufnr = vim.api.nvim_get_current_buf()
  local maps = {
    -- draw a line on HJKL keystrokes
    {"n", "J", "<C-v>j:VBox<CR>", {noremap = true, desc = "draw a line"}},
    {"n", "K", "<C-v>k:VBox<CR>", {noremap = true, desc = "draw a line"}},
    {"n", "L", "<C-v>l:VBox<CR>", {noremap = true, desc = "draw a line"}},
    {"n", "H", "<C-v>h:VBox<CR>", {noremap = true, desc = "draw a line"}},
    -- draw a box by pressing "f" with visual selection
    {"v", "f", ":VBox<CR>", {noremap = true, desc = "draw a box"}},
  }
  if not vim.b.venn_enabled then
    vim.b.venn_enabled = true
    vim.wo[winnr].virtualedit = "all"
    for _,v in pairs(maps) do
      vim.api.nvim_buf_set_keymap(bufnr, v[1], v[2], v[3], v[4])
    end
  else
    for _,v in pairs(maps) do
      vim.api.nvim_buf_del_keymap(bufnr, v[1], v[2])
    end
    vim.wo[winnr].virtualedit = nil
    vim.b.venn_enabled = nil
  end
end

return {
  [1] = {
    {"<ESC><ESC>", function () vim.v.hlsearch = 0 end, mode = "n", desc = "nohlsearch" },
    {"<leader>s", function () vim.o.spell = not vim.o.spell end, mode = "n", desc = "toggle spell"},
    {"<S-c>", function ()
      local it = vim.iter(vim.opt.listchars:get())
      local space = it:any(function (k,_) return k == "space" end)
      if space then
        vim.opt.listchars:remove("space")
      else
        vim.opt.listchars:prepend("space:⋅")
      end
    end, mode = "n", desc = "toggle display 'space'"},
    {"<leader>di", function () vim.notify(vim.inspect(vim.inspect_pos())) end, mode = "n", desc = "inspect at cursor"},
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
  ["venn"] = {
    { "<leader>v", toggle_venn, mode = "n", noremap = true, desc = "toggle venn" }
  },
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>" },
  },
}
