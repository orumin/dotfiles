return function()
  local treesitter_config = require("nvim-treesitter.configs")

  vim.treesitter.language.register('yaml', 'ansible')

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
