local utils = require("envutils")
local G = utils:globals()
local palette = utils.get_palette()

if G.is_headless then
  vim.g.neovide_no_custom_clipboard = true
end

--#################################
-- Display
--#################################
-- Scale
vim.g.neovide_scale_factor = 1.0

-- Padding
vim.g.neovide_padding_top    = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right  = 0
vim.g.neovide_padding_left   = 0

-- Background color, transparency
local alpha = function()
  return string.format("%x", math.floor(255 * (vim.g.transparency or 0.85)))
end
vim.g.transparency = 0.85

if G.is_mac then
  vim.g.neovide_transparency = 0.0
  vim.g.neovide_background_color = palette.base .. alpha()
else
  vim.g.neovide_transparency = 0.85
end

-- Blur
vim.g.neovide_floating_blur_amount_x = 3.0
vim.g.neovide_floating_blur_amount_y = 3.0

-- Scroll Animation Length
vim.g.neovide_scroll_animation_length = 0.3

-- Hiding the mouse when typing
vim.g.neovide_hide_mouse_when_typing = true

-- Underline automatic scaling
vim.g.neovide_underline_automatic_scaling = true

-- Theme
vim.g.neovide_theme = 'auto'

--#################################
-- Functionality
--#################################
-- Refresh rate
vim.g.neovide_refresh_rate = 60
-- Idle refresh rate
vim.g.neovide_refresh_rate_idle = 5
-- No idle
vim.g.neovide_no_idle = true

-- Confirm quit
vim.g.neovide_confirm_quit = true

-- Fullscreen
vim.g.neovide_fullscreen = false
-- Remember previous window size
vim.g.neovide_remember_window_size = true

-- Profiler
vim.g.neovide_profiler = false

--#################################
-- Input settings
--#################################
-- macOS alt is meta
if G.is_mac then
  vim.g.neovide_input_macos_alt_is_meta = true
end
-- IME
--vim.g.neovide_input_ime = true

-- Touch deadzone
-- vim.g.neovide_touch_deadzone = 6.0
-- Touch drag timeout
-- vim.g.neovide_touch_drag_timeout = 0.17

--#################################
-- Cursor settings
--#################################
-- Animation length
vim.g.neovide_cursor_animation_length = 0.05
-- Animation trail size
vim.g.neovide_cursor_trail_size = 0.4

-- Antialiasing
vim.g.neovide_cursor_antialiasing = true

-- Animate in insert mode
vim.g.neovide_cursor_animate_in_insert_mode = true

-- Animate switch to command
vim.g.neovide_cursor_animate_command_line = true

-- Unfocused outline width
vim.g.neovide_cursor_unfocused_outline_width = 0.125

--#################################
-- Cursor particles
--#################################
---@alias neovideVfxMode "" | "railgun" | "torpedo" | "pixiedust" | "sonicboom" | "ripple" | "wireframe"
---@type neovideVfxMode
vim.g.neovide_cursor_vfx_mode = "railgun"
--#################################
-- Particle settings
--#################################
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_dencity = 15.0
vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_cursor_vfx_particle_phase = 1.5 -- only for 'railgun'
vim.g.neovide_cursor_vfx_particle_curl = 1.0
