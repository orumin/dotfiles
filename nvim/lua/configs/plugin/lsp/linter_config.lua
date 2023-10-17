return function ()
  local configs = require("configs")
  local lint = require("lint")
  lint.linters_by_ft = configs.linters
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    callback = function ()
      require("lint").try_lint()
    end,
  })
end
