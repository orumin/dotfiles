return function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.asciidoc = {
    install_info = {
      url = "https://github.com/cathaysia/tree-sitter-asciidoc",
      files = { "src/parser.c", "src/scanner.c" },
      branch = "master",
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
    filetype = "asciidoc"
  }
  local treesitter_config = require("nvim-treesitter.configs")

  vim.treesitter.language.register('yaml', 'ansible')
  vim.treesitter.language.register('markdown', 'copilot-chat')

  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"

  local tsconfig = {
    modules = {},
    sync_install = true,
    ensure_installed = {
      "bash", "bibtex", "bitbake", "c", "cmake", "comment", "cpp", "css", "csv", "cue",
      "devicetree", "diff", "dockerfile", "doxygen", "elvish", "fennel", "fish",
      "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      "html", "http", "ini", "java", "javascript", "jq", "json", "json5", "jsonc", "latex", "llvm",
      "lua", "luadoc", "luap", "luau", "make", "markdown", "markdown_inline", "mermaid", "meson", "nasm", "ninja", "nix",
      "objc", "ocaml", "ocaml_interface", "ocamllex", "pascal", "passwd", "perl", "proto", "python", "query", "regex",
      "requirements", "rst", "ruby", "rust", "scss", "sql", "ssh_config", "strace", "systemtap",
      "textproto", "todotxt", "toml", "typescript", "vim", "vimdoc", "vue", "xml", "yaml"
    },
    auto_install = true,
    ignore_install = {},
    parser_install_dir = nil,
    highlight = {
      enable = true, -- false will disable the whole extension
      --additional_vim_regex_highlighting = { "c", "cpp" },
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  }

  treesitter_config.setup(tsconfig)
end
