return function ()
  local dashboard_theme = require("alpha.themes.dashboard")
  local alpha = require("alpha")
  alpha.setup(dashboard_theme.config)
end
