return {
  config = function()
    local utils = require("envutils")
    local G = utils:globals()

    local ts_manager = require('tree-sitter-manager')
    if not ts_manager then
      vim.notify("tree-sitter-manager not found!", vim.log.levels.ERROR)
      return
    end

    local ensure_installed = {
      "bash", "bibtex", "bitbake", "c", "cmake", "comment", "cpp", "css", "csv", "cue",
      "devicetree", "diff", "dockerfile", "doxygen", "elvish", "fennel", "fish",
      "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      "html", "http", "ini", "java", "javascript", "jq", "json", "json5", "latex", "llvm",
      "lua", "luadoc", "luap", "luau", "make", "markdown", "markdown_inline", "mermaid", "meson", "nasm", "ninja", "nix", "nu",
      "objc", "ocaml", "ocaml_interface", "ocamllex", "pascal", "passwd", "perl", "proto", "python", "query", "regex",
      "requirements", "rst", "ruby", "rust", "scss", "sql", "ssh_config", "strace", "systemtap",
      "textproto", "todotxt", "toml", "typescript", "typst", "vim", "vimdoc", "vue", "xml", "yaml"
    }

    local languages = {
      asciidoc = {
        tier = 1,
        maintainers = {"cathayasia"},
        install_info = {
          url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
          branch = "master",
          revision = "v0.7.0",
          location = "tree-sitter-asciidoc",
          use_repo_queries = true,
        }
      },
      asciidoc_inline = {
        tier = 1,
        maintainers = {"cathayasia"},
        install_info = {
          url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
          branch = "master",
          revision = "v0.7.0",
          location = "tree-sitter-asciidoc-inline",
          use_repo_queries = true,
        },
      },
      plantuml = {
        tier = 1,
        maintainers = {"Szeliga"},
        install_info = {
          url = "https://github.com/Szeliga/tree-sitter-plantuml.git",
          branch = "master",
          revision = "a3cfbf844d727b077f0070769e6d1c0977cc58f9",
          use_repo_queries = true,
        },
      }
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.treesitter.language.register('asciidoc', 'asciidoc')
    vim.treesitter.language.register('plantuml', 'plantuml')
    vim.treesitter.language.register('yaml', 'ansible')
    vim.treesitter.language.register('markdown', 'copilot-chat')

    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    ts_manager.setup({
      ensure_installed = ensure_installed,
      auto_install = false,
      languages = languages,
      parser_dir = utils:path_concat({G.nvim_data_dir, "tree-sitter", "parsers"}),
      query_dir = utils:path_concat({G.nvim_data_dir, "tree-sitter", "queries"}),
    })
  end
}
