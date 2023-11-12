-- Embedding lua in wezterm has version 5.4 (wezterm/config/Cargo.toml -> dependencies -> mlua)
local keymaps = require("keymaps")
local utils = require("utils")
local restore = require("restore")
local status = require("status")
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = wezterm.config_builder()

config = require("appearance").setup(config)

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

for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
  if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGpu" then
    config.front_end = "WebGpu"
    config.webgpu_preferred_adapter = gpu
    config.webgpu_power_preference = "HighPerformance"
    break
  elseif gpu.backend == "Vulkan" and gpu.device_type == "IntegratedGpu" then
    config.front_end = "WebGpu"
    config.webgpu_preferred_adapter = gpu
    config.webgpu_power_preference = "LowPower"
    break
  end
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

config.launch_menu = launch_menu
config.ssh_domains = ssh_domains

return config
