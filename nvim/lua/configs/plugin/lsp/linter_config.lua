return function ()
  local configs = require("configs")
  local linters = {}
  for _, v in pairs(configs.linters) do
    linters = vim.tbl_extend("force", linters, v)
  end
  require("mason-nvim-lint").setup({
    automatic_installation = true,
    ensure_installed = linters
  })

  local lint = require("lint")
  lint.linters_by_ft = configs.linters
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    callback = function ()
      require("lint").try_lint()
    end,
  })
end
