local wezterm = require("wezterm")
local M = {}

M.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
M.disable_default_key_bindings = true
M.keys = {
  { mods = "LEADER|CTRL", key = "b", action=wezterm.action{SendString="\x02"} }, -- Send <C-b> to the terminal when pressing <C-b> twice
  { mods = "LEADER|SHIFT", key = "\"", action = wezterm.action.SplitVertical{domain="CurrentPaneDomain"} },
  { mods = "LEADER|SHIFT", key = "%", action = wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"} },
  { mods = "LEADER", key = "z", action = "TogglePaneZoomState" },
  { mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { mods = "LEADER", key = "o", action = wezterm.action.RotatePanes("Clockwise") },
  { mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
  { mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
  { mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
  { mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
  { mods = "LEADER|SHIFT", key = "H", action = wezterm.action.AdjustPaneSize{"Left", 5} },
  { mods = "LEADER|SHIFT", key = "J", action = wezterm.action.AdjustPaneSize{"Down", 5} },
  { mods = "LEADER|SHIFT", key = "K", action = wezterm.action.AdjustPaneSize{"Up", 5} },
  { mods = "LEADER|SHIFT", key = "L", action = wezterm.action.AdjustPaneSize{"Right", 5} },
  { mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
  { mods = "LEADER", key = "p", action = wezterm.action.ActivateTabRelative(-1) },
  { mods = "LEADER|SHIFT", key = "&", action = wezterm.action.CloseCurrentTab{confirm=true} },
  { mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane{confirm=true} },
}

for i = 0, 9 do
  table.insert(M.keys, {
    mods = "LEADER", key = tostring(i), action = wezterm.action.ActivateTab(i)
  })
end

return M


--tmux keybindings
--C-b C-z     Suspend the current client
--C-b Space   Select next layout
--C-b !       Break pane to a new window
--C-b #       List all paste buffers
--C-b $       Rename current session
--C-b '       Prompt for window index to select
--C-b (       Switch to previous client
--C-b )       Switch to next client
--C-b ,       Rename current window
--C-b -       Delete the most recent paste buffer
--C-b .       Move the current window
--C-b /       Describe key binding
--C-b :       Prompt for a command
--C-b ;       Move to the previously active pane
--C-b =       Choose a paste buffer from a list
--C-b ?       List key bindings
--C-b C       Customize options
--C-b D       Choose a client from a list
--C-b E       Spread panes out evenly
--C-b L       Switch to the last client
--C-b M       Clear the marked pane
--C-b ]       Paste the most recent paste buffer
--C-b d       Detach the current client
--C-b f       Search for a pane
--C-b i       Display window information
--C-b m       Toggle the marked pane
--C-b o       Select the next pane
--C-b q       Display pane numbers
--C-b s       Choose a session from a list
--C-b t       Show a clock
--C-b w       Choose a window from a list
--C-b z       Zoom the active pane
--C-b {       Swap the active pane with the pane above
--C-b }       Swap the active pane with the pane below
--C-b ~       Show messages
--C-b DC      Reset so the visible part of the window follows the cursor
--C-b PPage   Enter copy mode and scroll up
--C-b M-1     Set the even-horizontal layout
--C-b M-2     Set the even-vertical layout
--C-b M-3     Set the main-horizontal layout
--C-b M-4     Set the main-vertical layout
--C-b M-5     Select the tiled layout
--C-b M-n     Select the next window with an alert
--C-b M-o     Rotate through the panes in reverse
--C-b M-p     Select the previous window with an alert
--C-b S-Up    Move the visible part of the window up
--C-b S-Down  Move the visible part of the window down
--C-b S-Left  Move the visible part of the window left
--C-b S-Right Move the visible part of the window right
