return function ()
  local global_settings = require("configs.global_settings")
  local lint = require("lint")
  lint.linters_by_ft = global_settings.linters
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    callback = function ()
      require("lint").try_lint()
    end,
  })
end
