local treesitter_config = require("nvim-treesitter.configs")
local strategy
local ok, ts_rainbow = pcall(require, "ts-rainbow")
if ok then
  strategy = ts_rainbow.strategy.global
else
  pr_error("error loading ts-rainbow")
end

treesitter_config.setup({
  ensure_installed = {"c", "cpp", "lua", "markdown", "markdown_inline", "rust"},
  highlight = {
    enable = true,              -- false will disable the whole extension
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
