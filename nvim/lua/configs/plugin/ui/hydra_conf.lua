return function ()
  local Hydra = require("hydra")
  local cmd = require("hydra.keymap-util").cmd
  local gitsigns = require("gitsigns")
  local neogit_hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

  local neogit_ui = {
    name = "Git",
    hint = neogit_hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        border = "rounded",
      },
      on_enter = function ()
        vim.cmd "mkview"
        vim.cmd "silent! %foldopen!"
        vim.bo.modifiable = false
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
      end,
      on_exit = function ()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd "loadview"
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd "normal zv"
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end
    },
    mode = {"n", "x"},
    body = "<leader>g",
    heads = {
      {
        "J",
        function ()
          if vim.wo.diff then return "]c" end
          vim.schedule(function () gitsigns.next_hunk() end)
          return "<Ignore>"
        end,
        { expr = true, desc = "next hunk" }
      },
      {
        "K",
        function ()
          if vim.wo.diff then return "[c" end
          vim.schedule(function () gitsigns.prev_hunk() end)
          return "<Ignore>"
        end,
        { expr = true, desc = "prev hunk" }
      },
      { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
      { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
      { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
      { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
      { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
      { "b", gitsigns.blame_line, { desc = "blame" } },
      { "B", function () gitsigns.blame_line({full = true}) end, { desc = "blame show full" } },
      { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
      { "<Enter>", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
      { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    }
  }

  local telescope_hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

  local telescope_ui = {
     name = 'Telescope',
     hint = telescope_hint,
     config = {
        color = 'teal',
        invoke_on_body = true,
        hint = {
           position = 'middle',
           border = 'rounded',
        },
     },
     mode = 'n',
     body = '<Leader>f',
     heads = {
        { 'f', cmd 'Telescope find_files' },
        { 'g', cmd 'Telescope live_grep' },
        { 'o', cmd 'Telescope oldfiles', { desc = 'recently opened files' } },
        { 'h', cmd 'Telescope help_tags', { desc = 'vim help' } },
        { 'm', cmd 'MarksListBuf', { desc = 'marks' } },
        { 'k', cmd 'Telescope keymaps' },
        { 'O', cmd 'Telescope vim_options' },
        { 'r', cmd 'Telescope resume' },
        { 'p', cmd 'Telescope projects', { desc = 'projects' } },
        { '/', cmd 'Telescope current_buffer_fuzzy_find', { desc = 'search in file' } },
        { '?', cmd 'Telescope search_history',  { desc = 'search history' } },
        { ';', cmd 'Telescope command_history', { desc = 'command-line history' } },
        { 'c', cmd 'Telescope commands', { desc = 'execute command' } },
        { 'u', cmd 'silent! %foldopen! | UndotreeToggle', { desc = 'undotree' }},
        { '<Enter>', cmd 'Telescope', { exit = true, desc = 'list all pickers' } },
        { '<Esc>', nil, { exit = true, nowait = true } },
     }
  }
  -- TODO: add dap mode
  -- https://github.com/Allaman/nvim/blob/90e4e550d9aa6a2f870cf5a31bde257622243005/lua/core/plugins/hydra/dap.lua
  -- memo
  Hydra(neogit_ui)
  Hydra(telescope_ui)
end
