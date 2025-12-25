---@source ./utils.lua
local utils = require("utils") --[[@as wezutils]]
---Pull in the wezterm API
---@module 'wezterm-types.lua.wezterm.types.wezterm'
local wezterm = require("wezterm")
local mux = wezterm.mux

local state_file_path = utils.path_concat({utils.cache_dir, "window_size"})

-- https://github.com/wez/wezterm/issues/256#issuecomment-1501101484
---@class wezWindowSize
---@field save_window_size_on_startup fun()
---@field save_window_size_on_resize fun(window: any, pane: any)
local M = {}

function M.save_window_size_on_startup()
  if not utils.mk_cache_dir() then
    wezterm.log_warn("cannot create directory: " .. utils.cache_dir)
    return
  end

  local f<close> = io.open(state_file_path, "r")
  if f ~= nil then
    local _, _, width, height = string.find(f:read(), "(%d+),(%d+)")
    mux.spawn_window{ width = tonumber(width), height = tonumber(height) }
  else
    local _, _, window = mux.spawn_window{}
    window:gui_window():maximize()
  end
end

---@diagnostic disable-next-line: unused-local
function M.save_window_size_on_resize(window, pane)
  local tab = pane:tab():get_size()
  local cols = tab["cols"]
  local rows = tab["rows"] + 2
  local contents = string.format("%d,%d", cols, rows)
  local f<close> = io.open(state_file_path, "w")
  if f then f:write(contents) end
end

return M
