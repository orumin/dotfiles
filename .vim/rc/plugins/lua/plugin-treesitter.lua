require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
