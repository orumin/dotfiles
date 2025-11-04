---@type Wezterm
local wezterm = require("wezterm")

---@class wezutils
---@field is_win boolean
---@field cache_dir string
---@field path_sep string
---@field icons table
---@field shell_prog string
---@field path_concat fun(dir_table: string[]): string
---@field has_executable_in_path fun(name: string): string?
---@field mk_cache_dir fun(): boolean
local M = {}

M.is_win = wezterm.target_triple == "x86_64-pc-windows-msvc"
M.is_mac = wezterm.target_triple:find("darwin") ~= nil
M.path_sep = M.is_win and "\\" or "/"

-- icons
M.icons = {
  process = {
    cmake = {
      wezterm.nerdfonts.dev_cmake,
      color = {
        fg = "#FFFFFF"
      },
    },
    docker = {
      wezterm.nerdfonts.md_docker,
      color = {
        fg = "#4169e1",
      },
    },
    gcc = {
      wezterm.nerdfonts.dev_gcc,
      color = {
        fg = "#FFCFAB",
      },
    },
    git = {
      wezterm.nerdfonts.dev_git,
      color = {
        fg = "#F54D27",
      },
    },
    github = {
      wezterm.nerdfonts.dev_github,
      color = {
        fg = "#000000",
      },
    },
    go = {
      wezterm.nerdfonts.dev_go,
      color = {
        fg = "#00ADD8",
      },
    },
    java = {
      wezterm.nerdfonts.dev_java,
      color = {
        fg = "#EA2E2F",
      },
    },
    jira = {
      wezterm.nerdfonts.dev_jira,
      color = {
        fg = "#1967DC",
      },
    },
    less = {
      wezterm.nerdfonts.dev_less,
      color = {
        fg = "#FFFFFF",
      },
    },
    node = {
      wezterm.nerdfonts.md_language_typescript,
      color = {
        fg = "#1E90FF",
      },
    },
    nvim = {
      wezterm.nerdfonts.linux_neovim,
      color = {
        fg = "#32CD32",
      },
    },
    python = {
      wezterm.nerdfonts.dev_python,
      color = {
        fg = "#FFD700",
      },
    },
    pwsh = {
      wezterm.nerdfonts.md_powershell,
      color = {
        fg = "#273E57",
      },
    },
    sh = {
      wezterm.nerdfonts.dev_terminal,
      color = {
        fg = "#808080"
      }
    },
    task = {
      wezterm.nerdfonts.cod_server_process,
      color = {
        fg = "#FF7F50",
      },
    },

    fallback = {
      wezterm.nerdfonts.md_console_network,
      color = {
        fg = "#AE8B2D",
      },
    },
  },
  window = {
    close = {
      [1] = " " .. (M.is_mac and wezterm.nerdfonts.md_circle_medium or wezterm.nerdfonts.cod_chrome_close) .. "  ",
      color = {
        fg = function() return M.is_mac and "#FF605C" or "white" end,
        bg = function(fallback) return fallback end,
      },
      hover = {
        [1] = " " .. (M.is_mac and wezterm.nerdfonts.md_close_circle or wezterm.nerdfonts.cod_chrome_close) .. "  ",
        color = {
          fg = function() return M.is_mac and "#FF605C" or "white" end,
          bg = function(fallback) return M.is_win and "red" or fallback end,
        },
      },
    },
    hide = {
      [1] = " " .. (M.is_mac and wezterm.nerdfonts.md_circle_medium or wezterm.nerdfonts.fa_window_minimize) .. "  ",
      color = {
        fg = function() return M.is_mac and "#FFBD44" or "white" end,
        bg = function(fallback) return fallback end,
      },
      hover = {
        [1] = " " .. (M.is_mac and wezterm.nerdfonts.md_minus_circle or wezterm.nerdfonts.fa_window_minimize) .. "  ",
        color = {
          fg = function() return M.is_mac and "#FFBD44" or "white" end,
          bg = function(fallback) return fallback end,
        },
      },
    },
    maximize = {
      [1] = " " .. (M.is_mac and wezterm.nerdfonts.md_circle_medium or wezterm.nerdfonts.fa_window_maximize) .. "  ",
      color = {
        fg = function() return M.is_mac and "#00CA4E" or "white" end,
        bg = function(fallback) return fallback end,
      },
      hover = {
        [1] = " " .. (M.is_mac and wezterm.nerdfonts.md_share_circle or wezterm.nerdfonts.fa_window_maximize) .. "  ",
        color = {
          fg = function() return M.is_mac and "#00CA4E" or "white" end,
          bg = function(fallback) return fallback end,
        },
      },
    },
  }
}

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
---@param s string
---@return string basename
function M.basename(s)
  local ret, _ = string.gsub(s, '(.*[/\\])(.*)', '%2')
  return ret
end

---@param s string
---@return {[1]: string, color: {fg: string}}
function M.get_icon(s)
  local ret = M.icons.process.fallback
  if string.find(s, "bash") or
    string.find(s, "fish") or
    string.find(s, "zsh") then
    ret = M.icons.process.sh
  elseif string.find(s, "cmake") then
    ret = M.icons.process.cmake
  elseif string.find(s, "docker") then
    ret = M.icons.process.docker
  elseif string.find(s, "gcc") then
    ret = M.icons.process.gcc
  elseif string.find(s, "gh") then
    ret  = M.icons.process.github
  elseif string.find(s, "git") then
    ret = M.icons.process.git
  elseif string.find(s, "go") then
    ret = M.icons.process.go
  elseif string.find(s, "java") then
    ret = M.icons.process.java
  elseif string.find(s, "jira") then
    ret = M.icons.process.jira
  elseif string.find(s, "less") then
    ret = M.icons.process.less
  elseif string.find(s, "node") then
    ret = M.icons.process.node
  elseif string.find(s, "powershell") or
    string.find(s, "pwsh") then
    ret = M.icons.process.pwsh
  elseif string.find(s, "python") then
    ret = M.icons.process.python
  elseif string.find(s, "task") then
    ret = M.icons.process.task
  elseif string.find(s, "vim") then
    ret = M.icons.process.nvim
  end

  return ret
end

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
  if M.has_executable_in_path("nu") ~= nil then
    M.shell_prog = "nu.exe"
  elseif M.has_executable_in_path("pwsh") ~= nil then
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
    command = "if [ ! -e " .. M.cache_dir .. " ]; then mkdir -p " .. M.cache_dir .. "; fi"
  end
  print(command)
  return os.execute(command) or false
end

return M
