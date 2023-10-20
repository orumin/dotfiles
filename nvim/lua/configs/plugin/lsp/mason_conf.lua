return function()
  local configs = require("configs")

  local icons = {
    ui = require("configs.ui.icons").get("ui"),
    misc = require("configs.ui.icons").get("misc")
  }

  local linters = {}
  for _, v in pairs(configs.linters) do
    vim.list_extend(linters, v)
  end

  local mason = require("mason")
  mason.setup({
    ensure_installed = linters,
    ui = {
      border = configs.window_style.border,
      icons = {
        package_pending = icons.ui.Modified_alt,
        package_installed = icons.ui.Check,
        package_uninstalled = icons.misc.Ghost
      }
    },
  })
end
