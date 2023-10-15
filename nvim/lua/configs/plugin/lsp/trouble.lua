local icons = {
  diagnostics = require("configs.ui.icons").get("diagnostics"),
  ui = require("configs.ui.icons").get("ui"),
}
return {
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
}

