return function()
  local treesitter_config = require("nvim-treesitter.configs")

  vim.treesitter.language.register('yaml', 'ansible')

  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"

  local tsconfig = {
    modules = {},
    sync_install = false,
    ensure_installed = {
      "bash", "c", "cmake", "comment", "cpp", "diff", "fish",
      "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      "http", "jq", "json", "json5", "latex", "llvm",
      "lua", "luadoc", "luap", "make", "markdown", "markdown_inline", "ninja",
      "passwd", "python", "query", "regex", "rst", "rust", "sql", "todotxt", "toml", "vim", "vimdoc", "yaml"
    },
    auto_install = true,
    ignore_install = {},
    parser_install_dir = nil,
    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = { "c", "cpp" },
    },
    indent = {
      enable = true,
    },
  }

  treesitter_config.setup(tsconfig)
end
