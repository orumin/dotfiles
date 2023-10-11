local palette = require("utils").get_palette()

local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end
vim.g.neovide_transparency = 0.85
vim.g.transparency = 0.85
vim.g.neovide_background_color = palette.base .. alpha()

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_scroll_animation_length = 0.3

vim.g.neovide_hide_mouse_when_typing = true

vim.g.neovide_underline_automatic_scaling = true

vim.g.neovide_theme = 'auto'

vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_no_idle = true

vim.g.neovide_confirm_quit = true

vim.g.neovide_fullscreen = false
vim.g.neovide_remember_window_size = true

vim.g.neovide_profiler = false

vim.g.neovide_input_ime = true

-- vim.g.neovide_touch_deadzone = 6.0
-- vim.g.neovide_touch_drag_timeout = 0.17

vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_trail_size = 0.4

vim.g.neovide_cursor_antialiasing = true

vim.g.neovide_cursor_animate_in_insert_mode = true

vim.g.neovide_cursor_animate_command_line = true

vim.g.neovide_cursor_unfocused_outline_width = 0.125

vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_dencity = 15.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_cursor_vfx_particle_phase = 1.5 -- only for 'railgun'
vim.g.neovide_cursor_vfx_particle_curl = 1.0
