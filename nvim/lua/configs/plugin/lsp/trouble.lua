local icons = {
  diagnostics = require("configs.ui.icons").get("diagnostics"),
  ui = require("configs.ui.icons").get("ui"),
}
return function ()
  require("trouble").setup({
    icons = {
      fold_closed = icons.ui.ArrowClosed,
      fold_open = icons.ui.ArrowOpen,
    },
    win_config = { border = "rounded" }
  })
end

