return function ()
  local opts = {
    integrations = {
      alpha = true,
      bufferline = true,
      blink_cmp = true,
      colorful_winsep = {
        enabled = true,
        color = "lavender"
      },
      dap = true,
      dap_ui = true,
      diffview = true,
      dropbar = {
        enabled = true,
        color_mode = true
      },
      fidget = true,
      gitgraph = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = "lavender",
        colored_indent_levels = true,
      },
      illuminate = {
        enabled = true,
        lsp = true
      },
      lsp_trouble = true,
      markdown = true,
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
      neogit = true,
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      rainbow_delimiters = true,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = {
        enabled = true,
        style = "nvchad"
      },
      treesitter = true,
      treesitter_context = true,
      which_key = true,
      window_picker = true,
    }
  }

  require("catppuccin").setup(opts)
end
