return {
  config = function()
    local treesitter = require('nvim-treesitter')
    if not treesitter then
      vim.notify("nvim-treesitter not found!", vim.log.levels.ERROR)
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
    local already_installed = require('nvim-treesitter.config').get_installed()
    if not already_installed then
      already_installed = {}
    end
    local parsers_to_install = vim.iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()
    treesitter.install(parsers_to_install)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
      callback = function()
        local parsers = require('nvim-treesitter.parsers')
        if not parsers then
          vim.notify("Failed to get parser configs!", vim.log.levels.ERROR)
          return
        end
        parsers.asciidoc = {
          tier = 1,
          maintainers = {"cathayasia"},
          install_info = {
            url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
            branch = "master",
            revision = "v0.7.0",
            location = "tree-sitter-asciidoc",
            queries = "tree-sitter-asciidoc/queries",
          }
        }
        --parsers.asciidoc_inline = {
        --  tier = 1,
        --  maintainers = {"cathayasia"},
        --  install_info = {
        --    url = "https://github.com/cathaysia/tree-sitter-asciidoc.git",
        --    branch = "master",
        --    revision = "v0.7.0",
        --    location = "tree-sitter-asciidoc-inline",
        --    queries = "tree-sitter-asciidoc-inline/queries",
        --  },
        --}
        parsers.plantuml = {
          tier = 1,
          maintainers = {"Szeliga"},
          install_info = {
            url = "https://github.com/Szeliga/tree-sitter-plantuml.git",
            branch = "master",
            revision = "a3cfbf844d727b077f0070769e6d1c0977cc58f9",
            queries = "queries/plantuml",
          },
        }
      end
    })

    vim.treesitter.language.register('asciidoc', 'asciidoc')
    vim.treesitter.language.register('plantuml', 'plantuml')
    vim.treesitter.language.register('yaml', 'ansible')
    vim.treesitter.language.register('markdown', 'copilot-chat')

    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/tree-sitter",
    })
  end
}
