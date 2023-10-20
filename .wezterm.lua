-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.8

config.font_size = 9.0

config.use_ime = true

--config.hide_tab_bar_if_only_one_tab = true

config.adjust_window_size_when_changing_font_size = false

config.window_decorations = "RESIZE"

return config
