local icon = require("configs.ui.icon")
return {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  signs = {
    -- icons / text used for a diagnostic
    error = icon.diagnostic_symbols.error,
    warning = icon.diagnostic_symbols.warn,
    hint = icon.diagnostic_symbols.hint,
    information = icon.diagnostic_symbols.info,
    other = icon.diagnostic_symbols.other,
  },
}

