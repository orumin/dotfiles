local icons = {
  diagnostics = require("configs.ui.icons").get("diagnostics"),
  ui = require("configs.ui.icons").get("ui"),
}
return function ()
  local telescope_conf = require("editor.telescope_conf")
  local trouble = require("trouble.providers.telescope")
  local i_maps = telescope_conf.defaults.mappings.i and telescope_conf.defaults.mappings.i or {}
  local n_maps = telescope_conf.defaults.mappings.n and telescope_conf.defaults.mappings.n or {}
  i_maps["<C-t>"] = trouble.open_with_trouble
  n_maps["<C-t>"] = trouble.open_with_trouble
  require("telescope.config").set_defaults(telescope_conf.defaults)

  require("trouble").setup({
    icons = true,
    fold_closed = icons.ui.ArrowClosed,
    fold_open = icons.ui.ArrowOpen,
    signs = {
      error = icons.diagnostics.Error,
      warning = icons.diagnostics.Warning,
      hint = icons.diagnostics.Hint,
      information = icons.diagnostics.Information,
      other = icons.diagnostics.Question,
    },
    win_config = { border = "rounded" }
  })
end

