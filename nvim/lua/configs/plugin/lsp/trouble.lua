local icons = {
  diagnostics = require("configs.ui.icons").get("diagnostics"),
  ui = require("configs.ui.icons").get("ui"),
}
return function ()
  local telescope_conf = require("editor.telescope_conf")
  local trouble = require("trouble.sources.telescope")
  local i_maps = telescope_conf.defaults.mappings.i and telescope_conf.defaults.mappings.i or {}
  local n_maps = telescope_conf.defaults.mappings.n and telescope_conf.defaults.mappings.n or {}
  i_maps["<C-t>"] = trouble.open
  n_maps["<C-t>"] = trouble.open
  require("telescope.config").set_defaults(telescope_conf.defaults)

  require("trouble").setup({
    icons = {
      fold_closed = icons.ui.ArrowClosed,
      fold_open = icons.ui.ArrowOpen,
    },
    win_config = { border = "rounded" }
  })
end

