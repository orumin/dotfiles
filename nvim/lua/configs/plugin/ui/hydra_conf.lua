local M = {}
M.keymaps = {
  ["git"] = { [1]="<leader>g", [2]=nil, mode = {"n", "x"}, desc = "Git" },
  ["telescope"] = { [1]="<leader>f", [2]=nil, mode = "n", desc = "Telescope" },
  ["dap"] = { [1]="<leader>dh", [2]=nil, mode = {"n", "x"}, desc = "DAP" },
  ["venn"] = { [1]="<leader>v", [2]=nil, mode = "n", desc = "Draw Diagram" }
}

local function setup_gitmode()
  local cmd = require("hydra.keymap-util").cmd
  local gitsigns = require("gitsigns")
  local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

  return {
    name = M.keymaps["git"].desc,
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = {
        border = "rounded",
      },
      on_enter = function ()
        vim.cmd.mkview()
        vim.cmd "silent! %foldopen!"
        vim.bo.modifiable = false
        gitsigns.toggle_signs(true)
        gitsigns.toggle_linehl(true)
      end,
      on_exit = function ()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd.loadview()
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd.normal('zv')
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end
    },
    mode = M.keymaps["git"].mode,
    body = M.keymaps["git"][1],
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
      { "s", cmd "Gitsigns stage_hunk", { silent = true, desc = "stage hunk" } },
      { "u", gitsigns.undo_stage_hunk, { desc = "undo last stage" } },
      { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
      { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
      { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
      { "b", gitsigns.blame_line, { desc = "blame" } },
      { "B", function () gitsigns.blame_line({full = true}) end, { desc = "blame show full" } },
      { "/", gitsigns.show, { exit = true, desc = "show base file" } }, -- show the base of the file
      { "<Enter>", cmd "Neogit", { exit = true, desc = "Neogit" } },
      { "q", nil, { exit = true, nowait = true, desc = "exit" } },
    }
  }
end

local function setup_telescope()
  local builtin = require("telescope.builtin")
  local hint = [[
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

  return {
    name = M.keymaps["telescope"].desc,
    hint = hint,
    config = {
      color = 'teal',
      invoke_on_body = true,
      hint = {
        position = 'middle',
        border = 'rounded',
      },
    },
    mode = M.keymaps["telescope"].mode,
    body = M.keymaps["telescope"][1],
    heads = {
      { 'f', builtin.find_files, { desc = "find files" } },
      { 'g', builtin.live_grep, { desc = "live grep" } },
      { 'o', builtin.oldfiles, { desc = "recently opened files" } },
      { 'h', builtin.help_tags, { desc = "vim help" } },
      { 'm', builtin.marks, { desc = "marks" } },
      { 'k', builtin.keymaps, { desc = "show keymaps" } },
      { 'O', builtin.vim_options, { desc = "show vim options" } },
      { 'r', builtin.resume, { desc = "telescope resume" } },
      { 'p', require("session-lens").search_session, { desc = "projects" } },
      { '/', builtin.current_buffer_fuzzy_find, { desc = "search in file" } },
      { '?', builtin.search_history,  { desc = "search history" } },
      { ';', builtin.command_history, { desc = "command-line history" } },
      { 'c', builtin.commands, { desc = "execute command" } },
      { 'u', require("telescope").extensions.undo.undo, { desc = "undotree" }},
      { '<Enter>', builtin.builtin, { exit = true, desc = "list all pickers" } },
      { '<Esc>', nil, { exit = true, nowait = true } },
    }
  }
end

local function setup_dapmode()
  local dap = require("dap")
  local hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _i_: step into   _x_: Quit             ^ ^                 ^ ^
 _o_: step out    _X_: Stop             ^ ^
 _c_: to cursor   _C_: Close UI
 ^
 ^ ^              _q_: exit
]]

  return {
    name = M.keymaps["dap"].desc,
    hint = hint,
    config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
        position = 'bottom',
        border = 'rounded'
      }
    },
    mode = M.keymaps["dap"].mode,
    body = M.keymaps["dap"][1],
    heads = {
      { 'n', dap.step_over, {silent = true} },
      { 'i', dap.step_into, {silent = true} },
      { 'o', dap.step_out,  {silent = true} },
      { 'c', dap.run_to_cursor, {silent = true} },
      { 's', dap.continue, {silent = true} },
      { 'x', function () dap.disconnect({ terminateDebuggee = false }) end, {exit=true, silent=true} },
      { 'X', dap.close, {silent=true} },
      { 'C', function ()
        require("dapui").close()
        vim.cmd.DapVirtualTextForceRefresh()
      end, {silent=true} },
      { 'b', dap.toggle_breakpoint, {silent=true} },
      { 'K', function ()
        require("dap.ui.widgets").hover()
      end, {silent=true} },
      { 'q', nil, {exit=true, nowait=true} },
    }
  }
end

local function setup_venn()
  local hint = [[
 Arrow^^^^^^   Select region with <C-v>
 ^ ^ _K_ ^ ^   _f_: surround it with box
 _H_ ^ ^ _L_                      _<ESC>_
 ^ ^ _J_ ^ ^
]]

  return {
    name = M.keymaps["venn"].desc,
    hint = hint,
    config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
        position = 'bottom',
        border = 'rounded'
      },
      on_enter = function ()
        vim.o.virtualedit = "all"
      end,
    },
    mode = M.keymaps["venn"].mode,
    body = M.keymaps["venn"][1],
    heads = {
      {"H", "<C-v>h:VBox<CR>", {silent = true}},
      {"J", "<C-v>j:VBox<CR>", {silent = true}},
      {"K", "<C-v>k:VBox<CR>", {silent = true}},
      {"L", "<C-v>l:VBox<CR>", {silent = true}},
      {"f", ":VBox<CR>", {silent = true, mode = "v"}},
      {"<ESC>", nil, {exit = true}},
    }
  }
end

M.get_keymaps = function ()
  local ret = {}
  for _, v in pairs(M.keymaps) do
    table.insert(ret, v)
  end
  return ret
end

M.setup = function ()
  local Hydra = require("hydra")
  Hydra(setup_gitmode())
  Hydra(setup_telescope())
  Hydra(setup_dapmode())
  Hydra(setup_venn())
end

return M
