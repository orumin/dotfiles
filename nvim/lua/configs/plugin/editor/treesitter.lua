return function()
  vim.filetype.add({
    extension = {
      adoc = "asciidoc"
    }
  })

  ---@class MyParserConfig : { [string]: ParserInfo}
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.asciidoc = {
    filetype = "asciidoc",
    maintainers = {"cathayasia"},
    install_info = {
      url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
      files = { "tree-sitter-asciidoc/src/parser.c", "tree-sitter-asciidoc/src/scanner.c" },
      branch = "master",
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
  }
  parser_config.asciidoc_inline = {
    filetype = "asciidoc",
    maintainers = {"cathayasia"},
    install_info = {
      url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
      files = { "tree-sitter-asciidoc_inline/src/parser.c", "tree-sitter-asciidoc_inline/src/scanner.c" },
      branch = "master",
      generate_requires_npm = false,
      requires_generate_from_grammar = false,
    },
  }

  local treesitter_config = require("nvim-treesitter.configs")

  vim.treesitter.language.register('yaml', 'ansible')
  vim.treesitter.language.register('markdown', 'copilot-chat')

  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"

  local tsconfig = {
    modules = {},
    sync_install = false,
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
