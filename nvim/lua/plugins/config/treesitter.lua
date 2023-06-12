local treesitter_config = require("nvim-treesitter.configs")
local strategy
local ok, ts_rainbow = pcall(require, "ts-rainbow")
if ok then
  strategy = ts_rainbow.strategy.global
else
  pr_error("error loading ts-rainbow")
end

treesitter_config.setup({
  ensure_installed = {
    "bash", "c", "cmake", "comment", "cpp", "diff", "fish",
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "http", "jq", "json", "json5", "latex", "llvm",
    "lua", "luadoc", "luap", "make", "markdown", "markdown_inline", "ninja",
    "passwd", "python", "query", "regex", "rst", "rust", "sql", "todotxt", "toml", "vim", "vimdoc", "yaml"
  },
  auto_install = true,
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    -- disable = {"jsx", "cpp"},
    query = "rainbow-parens",
    strategy = strategy
  },
})
