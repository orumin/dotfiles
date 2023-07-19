return {
  integrations = {
    bufferline = true,
    cmp = true,
    dap = {
      enabled = true,
      enable_ui = true,
    },
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    lsp_saga = true,
    lsp_trouble = true,
    mason = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    neotree = true,
    noice = true,
    notify = true,
    rainbow_delimiters = true,
    telescope = {
      enabled = true,
    },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  }
}
