require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp", "lua", "rust"},
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    -- disable = {"jsx", "cpp"},
    extended_mode = true,
    max_file_lines = nil,
    -- colors = {},
    -- termcolors = {}
  },
}
