local wezterm = require("wezterm")

---@class wezutils
---@field is_win boolean
---@field cache_dir string
---@field path_sep string
---@field shell_prog string
---@field path_concat fun(dir_table: string[]): string
---@field has_executable_in_path fun(name: string): string?
---@field mk_cache_dir fun(): boolean
local M = {}

M.is_win = wezterm.target_triple == "x86_64-pc-windows-msvc"
M.path_sep = M.is_win and "\\" or "/"

---@param path string
---@return boolean
local function check_file_existence(path)
  if path == nil then return false end
  local f<close> = io.open(path, "r")
  local ret = f ~= nil
  if not ret and M.is_win then
    local f2<close> = io.open(path .. ".exe", "r")
    ret = f2 ~= nil
  end
  return ret
end

function M.path_concat(dir_table)
  return table.concat(dir_table, M.path_sep)
end

M.cache_dir = M.path_concat({wezterm.home_dir, ".cache", "wezterm"})
local path_string = os.getenv("PATH")

function M.has_executable_in_path(name)
  if check_file_existence(name) then
    return name
  elseif path_string == nil then
    return nil
  end

  local sep = M.is_win and ";" or ":"
  local pattern = "([^"..sep.."]+)"..sep
  local last_pattern = "[^"..sep.."]+$"
  for p in string.gmatch(path_string, pattern) do
    local target_file = M.path_concat({p, name})
    if check_file_existence(target_file) then return target_file end
  end

  for p in string.gmatch(path_string, last_pattern) do
    local target_file = M.path_concat({p, name})
    if check_file_existence(target_file) then return target_file end
  end

  return nil
end

if M.is_win then
  if M.has_executable_in_path("pwsh") ~= nil then
    M.shell_prog = "pwsh.exe"
  elseif M.has_executable_in_path("powershell") ~= nil then
    M.shell_prog = "powershell.exe"
  else
    M.shell_prog = "cmd.exe"
  end
else
  M.shell_prog = os.getenv("SHELL") or "sh"
end

function M.mk_cache_dir()
  local command
  if M.is_win then
    -- libc's system() is always call cmd.exe as shell in Windows, not pwsh.exe/powershell.exe
    command = "if not exist " .. M.cache_dir .. " mkdir " .. M.cache_dir
  else
    command = "[ ! -e " .. M.cache_dir .. " ] && mkdir -p " .. M.cache_dir
  end
  return os.execute(command) or false
end

return M
