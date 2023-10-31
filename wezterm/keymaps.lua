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
  { mods = "LEADER|SHIFT", key = "C", action = wezterm.action.ShowLauncher },
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
  { mods = "LEADER", key = "[", action = "ActivateCopyMode" },
  { mods = "LEADER", key = "]", action = wezterm.action.PasteFrom("Clipboard") },
  { mods = "CTRL", key = "-", action = "DecreaseFontSize" },
  { mods = "CTRL|SHIFT", key = "+", action = "IncreaseFontSize" },
  { mods = "CTRL", key = "=", action = "IncreaseFontSize" },
}
for i = 0, 9 do
  table.insert(M.keys, {
    mods = "LEADER", key = tostring(i), action = wezterm.action.ActivateTab(i)
  })
end


M.key_tables = {
  copy_mode = {
    { mods = "NONE", key = "q", action = wezterm.action.CopyMode("Close") },
    { mods = "NONE", key = "i", action = wezterm.action.CopyMode("Close") },
    { mods = "NONE", key = "w", action = wezterm.action.CopyMode("MoveForwardWord") },
    { mods = "NONE", key = "b", action = wezterm.action.CopyMode("MoveBackwardWord") },
    { mods = "NONE", key = "0", action = wezterm.action.CopyMode("MoveToStartOfLine") },
    { mods = "NONE", key = "^", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
    { mods = "SHIFT", key = "^", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
    { mods = "NONE", key = "$", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
    { mods = "SHIFT", key = "$", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
    { mods = "NONE", key = "g", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
    { mods = "NONE", key = "G", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },
    { mods = "SHIFT", key = "G", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },
    { mods = "CTRL", key = "f", action = wezterm.action.CopyMode("PageDown") },
    { mods = "LEADER|CTRL", key = "b", action = wezterm.action.CopyMode("PageUp") },
    { mods = "NONE", key = "PageDown", action = wezterm.action.CopyMode("PageDown") },
    { mods = "NONE", key = "PageUp", action = wezterm.action.CopyMode("PageUp") },
    { mods = "NONE", key = "v", action = wezterm.action.CopyMode{ SetSelectionMode = "Cell" } },
    { mods = "NONE", key = "V", action = wezterm.action.CopyMode{ SetSelectionMode = "Line" } },
    { mods = "SHIFT", key = "V", action = wezterm.action.CopyMode{ SetSelectionMode = "Line" } },
    { mods = "CTRL", key = "v", action = wezterm.action.CopyMode{ SetSelectionMode = "Block" } },
    { mods = "NONE", key = "y", action = wezterm.action.Multiple{
        { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" }
      },
    },
    { mods = "NONE", key = "h", action = wezterm.action.CopyMode("MoveLeft") },
    { mods = "NONE", key = "j", action = wezterm.action.CopyMode("MoveDown") },
    { mods = "NONE", key = "k", action = wezterm.action.CopyMode("MoveUp") },
    { mods = "NONE", key = "l", action = wezterm.action.CopyMode("MoveRight") },
  },

  search_mode = {
    { mods = "NONE", key = "Escape", action = wezterm.action.CopyMode("ClearPattern") },
    { mods = "NONE", key = "n", action = wezterm.action.CopyMode("NextMatch") },
    { mods = "SHIFT", key = "N", action = wezterm.action.CopyMode("PriorMatch") },
  }
}

return M

