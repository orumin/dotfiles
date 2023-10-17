return function ()
  local custom_theme = require("configs.ui.dashboard")
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = custom_theme.header
  dashboard.section.buttons.val = custom_theme.buttons(dashboard.button)
  dashboard.section.footer.val = require("alpha.fortune")()

  for k, v in pairs(custom_theme.layout) do
    dashboard.config.layout[k] = v
  end

  for k, v in pairs(custom_theme.opts) do
    dashboard.config.opts[k] = v
  end

  alpha.setup(dashboard.config)
end
