local opts = {
  size = function(term)
    if term.direction == "horizontal" then
      return 25
    elseif term.direction == "vertical" then
      return math.ceil(vim.api.nvim_win_get_width(0) * 0.7)
    end
  end,
  --open_mapping = [[<c-\>]],
  hide_numbers = true,
  autochdir = false,
  shade_terminals = false,
  shading_factor = nil,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = false,
  persist_mode = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'single',
    winblend = 30,
  },
  winbar = {
    enabled = false,
    name_formatter = function(term)
      return term.name
    end
  }
}

return function ()
  require("toggleterm").setup(opts)
end
