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
---@type Wezterm
local wezterm = require("wezterm")

-- This table will hold the configuration.
---@type Config
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
--wezterm.on("update-right-status", status.update_right_status)
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
tabline.setup {
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd', padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = {
      'index',
      {
        'process',
        padding = { left = 0, right = 1 },
        process_to_icon = {
          ['nu'] = { wezterm.nerdfonts.md_chevron_right, color = { fg = scheme.ansi[3] } },
        },
      }
    },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime', 'battery' },
    tabline_z = { 'domain' },
  },
  extensions = {},
}

config.leader = keymaps.leader
config.disable_default_key_bindings = keymaps.disable_default_key_bindings
config.keys = keymaps.keys
local key_tables = config.key_tables or {}
key_tables.copy_mode = keymaps.key_tables.copy_mode
key_tables.search_mode = keymaps.key_tables.search_mode
config.key_tables = key_tables

local default_prog = { utils.shell_prog }
config.default_prog = default_prog
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
  args = default_prog
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
