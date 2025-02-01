---@type Wezterm
local wezterm = require("wezterm")
local M = {}

local bat_icon = {
  unknown = {
    [ 1] = '󱉝'
  },
  -- discharging
  discharging = {
    [ 1] = '󰁺', --  10%
    [ 2] = '󰁻', --  20%
    [ 3] = '󰁼', --  30%
    [ 4] = '󰁽', --  40%
    [ 5] = '󰁾', --  50%
    [ 6] = '󰁿', --  60%
    [ 7] = '󰂀', --  70%
    [ 8] = '󰂁', --  80%
    [ 9] = '󰂂', --  90%
    [10] = '󰁹', -- 100%
  },
  -- charging
  charging = {
    [ 1] = '󰢜', --  10%
    [ 2] = '󰂆', --  20%
    [ 3] = '󰂇', --  30%
    [ 4] = '󰂇', --  40%
    [ 5] = '󰂈', --  50%
    [ 6] = '󰢝', --  60%
    [ 7] = '󰂉', --  70%
    [ 8] = '󰂊', --  80%
    [ 9] = '󰂋', --  90%
    [10] = '󰂅', -- 100%
  }
}

---@param window Window
---@param pane Pane
function M.update_right_status(window, pane)
  local _ = pane
  local scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
  local active_bg = scheme.tab_bar.active_tab.bg_color
  local active_fg = scheme.tab_bar.active_tab.fg_color
  local inactive_bg = scheme.tab_bar.inactive_tab.bg_color
  --local inactive_fg = scheme.tab_bar.inactive_tab.fg_color
  --local SOFT_RIGHT_ARROW = wezterm.nerdfonts.pl_right_soft_divider
  local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

  local date = wezterm.strftime '%b %-d (%a) %H:%M '

  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    local state_of_charge = b.state_of_charge * 100
    if b.state == "Unknown" then
      bat = ' ' .. bat_icon.unknown[1]
    else
      local state = b.state=="Charging" and "charging" or "discharging"
      bat = ' ' .. bat_icon[state][math.ceil(state_of_charge/10)] .. ' ' .. string.format('%.0f%%', state_of_charge)
    end
  end

  local leader = ''
  if window:leader_is_active() then
    leader = 'LEADER'
  end

  window:set_right_status(wezterm.format({
    { Background = { Color = inactive_bg } },
    { Foreground = { Color = active_bg } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = active_bg } },
    { Foreground = { Color = active_fg } },
    { Text = " " .. leader .. " " },
    { Background = { Color = active_bg } },
    { Foreground = { Color = active_fg } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = inactive_bg } },
    { Foreground = { Color = active_bg } },
    { Text = SOLID_RIGHT_ARROW },
    { Background = { Color = active_bg } },
    { Foreground = { Color = active_fg } },
    { Text = bat .. '   ' .. date },
  }))
end

return M

