local opts = {
  size = 10,
  open_mapping = [[<C-\>]],
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
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    winblend = 30,
  },
}

return function ()
  require("toggleterm").setup(opts)
end
