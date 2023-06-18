local diagnostic_icons = require("configs.ui.icons").get("diagnostics")
return {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  signs = {
    -- icons / text used for a diagnostic
    error = diagnostic_icons.Error,
    warning = diagnostic_icons.Warning,
    hint = diagnostic_icons.Hint,
    information = diagnostic_icons.Information,
    other = diagnostic_icons.Question,
  },
}

