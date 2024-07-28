-- Embedding lua in wezterm has version 5.4 (wezterm/config/Cargo.toml -> dependencies -> mlua)
---@source ./keymaps.lua
local keymaps = require("keymaps")
---@source ./utils.lua
local utils = require("utils") --[[@as wezutils]]
---@source ./restore.lua
local restore = require("restore")
---@source ./status.lua
local status = require("status")
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = wezterm.config_builder()

---@source ./gpu.lua
local gpu_config = require("gpu") --[[@as WezConfigGpu]]
config = gpu_config.setup(config)

---@source ./appearance.lua
local appearance = require("appearance")
config = appearance.setup(config)

wezterm.on("decrease-opacity", appearance.decrease_opacity)
wezterm.on("increase-opacity", appearance.increase_opacity)
wezterm.on("gui-startup", restore.save_window_size_on_startup)
wezterm.on("window-resized", restore.save_window_size_on_resize)
wezterm.on("update-right-status", status.update_right_status)

config.leader = keymaps.leader
config.disable_default_key_bindings = keymaps.disable_default_key_bindings
config.keys = keymaps.keys
local key_tables = config.key_tables or {}
key_tables.copy_mode = keymaps.key_tables.copy_mode
key_tables.search_mode = keymaps.key_tables.search_mode
config.key_tables = key_tables

config.default_prog = { utils.shell_prog }
if not utils.is_win then
  config.default_prog[#config.default_prog+1] = "-l"
end

config.use_ime = true

config.adjust_window_size_when_changing_font_size = false

config.audible_bell = "Disabled"

config.automatically_reload_config = true

local launch_menu = {}
table.insert(launch_menu, {
  label = "system shell",
  args = config.default_prog
})
local btop_prog = {}
if utils.is_win then
  btop_prog = { "sudo.cmd", "btop.exe" }
else
  btop_prog = { "btop" }
end
table.insert(launch_menu, {
  label = "btop",
  args = btop_prog
})

local ssh_domains = {}
for host, ssh_config in pairs(wezterm.enumerate_ssh_hosts()) do
  table.insert(ssh_domains, {
    name = host,
    remote_address = ssh_config.hostname,
    --multiplexing = "None",
    assume_shell = "Posix",
    ssh_option = ssh_config

  })
end

local serial_ports = {}
for idx=0,9 do
  if not utils.is_win then
    table.insert(serial_ports, {
      name = "USB tty (ttyUSB"..idx..")",
      port = "/dev/ttyUSB"..idx,
      baud = 115200
    })
  else
    table.insert(serial_ports, {
      name = "serial COM"..idx.."",
      port = "COM"..idx,
      baud = 115200
    })
  end
end

config.launch_menu = launch_menu
config.ssh_domains = ssh_domains
config.serial_ports = serial_ports

return config
