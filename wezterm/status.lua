local wezterm = require("wezterm")
local M = {}

---@param window any
---@param pane  any
function M.update_right_status(window, pane)
  local _ = pane
  local scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
  local active_bg = scheme.tab_bar.active_tab.bg_color
  local active_fg = scheme.tab_bar.active_tab.fg_color
  local inactive_bg = scheme.tab_bar.inactive_tab.bg_color
  --local inactive_fg = scheme.tab_bar.inactive_tab.fg_color
  --local SOFT_RIGHT_ALLOW = wezterm.nerdfonts.pl_right_soft_divider
  local SOLID_RIGHT_ALLOW = wezterm.nerdfonts.pl_right_hard_divider
  local leader = ''
  if window:leader_is_active() then
    leader = 'LEADER'
  end
  window:set_right_status(wezterm.format({
    { Background = { Color = inactive_bg } },
    { Foreground = { Color = active_bg } },
    { Text = SOLID_RIGHT_ALLOW },
    { Background = { Color = active_bg } },
    { Foreground = { Color = active_fg } },
    { Text = " " .. leader .. " " },
  }))
end

return M

