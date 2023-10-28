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
      require("neo-tree.command").execute({
        toggle = true,
        dir = require("envutils").get_root(),
      })
    end,
    desc = "toggle NeoTree" }
  },
  ["nvim_lsp"] = require("configs.keymap.nvim-lsp"),
  ["pantran"] = {
    {"<leader>tr", mode = {"n", "x"}, function ()
      require("pantran").motion_translate()
    end, noremap = true, silent = true, expr = true, desc = "translate"},
    {"<leader>trr", mode = "n", function ()
      return require("pantran").motion_translate() .. "_"
    end, noremap = true, silent = true, expr = true, desc = "translate"},
  },
  ["pomodoro"] = {
    {"<leader>ps", function() require("piccolo-pomodoro").start() end, mode = "n", desc = "start pomodoro timer"},
    {"<leader>pp", function() require("piccolo-pomodoro").pause() end, mode = "n", desc = "pause pomodoro timer"},
    {"<leader>pt", function() require("piccolo-pomodoro").toggle() end, mode = "n", desc = "toggle pomodoro timer"},
    {"<leader>ph", function() require("piccolo-pomodoro").print_status() end, mode = "n", desc = "show pomodoro timer status"},
    {"<leader>pk", function() require("piccolo-pomodoro").skip() end, mode = "n", desc = "skip pomodoro timer"},
    {"<leader>pr", function() require("piccolo-pomodoro").reset() end, mode = "n", desc = "reset pomodoro timer"},
  },
  ["profile"] = {
    {"<F1>", function()
      local prof = require("profile")
      if prof and prof.is_recording() then
        prof.stop()
        vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
          if filename then
            prof.export(filename)
            --vim.notify(string.format("Wrote %s", filename))
          end
        end)
      else
        prof.start("*")
      end
    end, desc = "start/stop profiler"}
  },
  ["skkeleton"] = {
    {"<C-j>", "<Plug>(skkeleton-toggle)", mode = {"c", "i"}, desc="skk" }
  },
  ["ssr"] = {
    {"<leader>sr", function ()
      require("ssr").open()
    end, mode = {"n", "x"}, desc = "structual search & rename" }
  },
  ["toggleterm"] = {
    { "vtf", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=float\"<CR>", mode = "n", desc = "open float terminal" },
    { "vts", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=horizontal\"<CR>", mode = "n", desc = "open horizontal terminal" },
    { "vtv", "<Cmd>exe " .. vim.v.count1 .. ". \"ToggleTerm direction=vertical\"<CR>", mode = "n", desc = "open vertical terminal" }
  },
  ["trouble"] = require("configs.keymap.trouble"),
  ["windows"] = {
    {"<C-w>z", "<Cmd>WindowsMaximize<CR>" },
    {"<C-w>_", "<Cmd>WindowsMaximizeVertically<CR>" },
    {"<C-w>|", "<Cmd>WindowsMaximizeHorizontally<CR>" },
    {"<C-w>=", "<Cmd>WindowsEqualize<CR>" },
  },
}
