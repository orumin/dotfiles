local wezterm = require 'wezterm'
local M = {}

---@param window any
---@param pane  any
function M.update_right_status(window, pane)
  local _ = pane
  local leader = ''
  if window:leader_is_active() then
    leader = 'LEADER'
  end
  window:set_right_status(leader)
end

return M

