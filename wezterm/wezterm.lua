-- Embedding lua in wezterm has version 5.4 (wezterm/config/Cargo.toml -> dependencies -> mlua)
local keymaps = require("keymaps")
local utils = require("utils")
local restore = require("restore")
local status = require("status")
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages

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

config.color_scheme = "Catppuccin Mocha"

config.window_background_opacity = 0.8

config.font_size = 9.0

config.inactive_pane_hsb = {
  hue = 1.0, saturation = 1.0, brightness = 1.0
}

config.use_ime = true

--config.hide_tab_bar_if_only_one_tab = true

config.adjust_window_size_when_changing_font_size = false

config.window_decorations = "RESIZE"

config.automatically_reload_config = true

local ssh_domains = {}
for host, config in pairs(wezterm.enumerate_ssh_hosts()) do
  table.insert(ssh_domains, {
    name = host,
    remote_address = host,
    --multiplexing = "None",
    assume_shell = "Posix",
  })
end

config.ssh_domains = ssh_domains

return config
