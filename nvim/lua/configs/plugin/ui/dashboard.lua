return function ()
  local custom_theme = require("configs.ui.dashboard")
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = custom_theme.header
  dashboard.section.buttons.val = custom_theme.buttons(dashboard.button)
  dashboard.section.footer.val = require("alpha.fortune")()

  alpha.setup(dashboard.config)
end
