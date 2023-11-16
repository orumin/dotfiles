local M = {}

M.setup = function (config)
  local wezterm = require("wezterm")
  local utils = require("utils")

  local scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
  local bg = {}
  bg.h, bg.s, bg.l, bg.a = wezterm.color.parse(scheme.background):hsla()
  local transparent_bg = ("hsla(%s %s %s %s)"):format(bg.h, bg.s*100 .. "%", bg.l*100 .. "%", "40%")
  scheme.background = transparent_bg
  scheme.tab_bar.background = transparent_bg
  local active_tab_bg = {}
  active_tab_bg.h, active_tab_bg.s, active_tab_bg.l, active_tab_bg.a =
    wezterm.color.parse(scheme.tab_bar.active_tab.bg_color):hsla()
  scheme.tab_bar.active_tab.bg_color = ("hsla(%s %s %s %s)"):format(
    active_tab_bg.h,
    active_tab_bg.s*100 .. "%",
    active_tab_bg.l*100 .. "%",
    "100%"
  )
  local inactive_tab_bg = {}
  inactive_tab_bg.h, inactive_tab_bg.s, inactive_tab_bg.l, inactive_tab_bg.a =
  wezterm.color.parse(scheme.tab_bar.active_tab.bg_color):hsla()
  scheme.tab_bar.active_tab.bg_color = ("hsla(%s %s %s %s)"):format(
    inactive_tab_bg.h,
    inactive_tab_bg.s*100 .. "%",
    inactive_tab_bg.l*100 .. "%",
    "100%"
  )

  config.use_fancy_tab_bar = false
  local SOFT_LEFT_ALLOW = wezterm.nerdfonts.pl_left_soft_divider
  local SOLID_LEFT_ALLOW = wezterm.nerdfonts.pl_left_hard_divider
  local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
      return title
    end
    return tab_info.active_pane.title
  end

  config.tab_max_width = 20
  wezterm.on("format-tab-title", function (tab, tabs, panes, conf, hover, max_width)
    local active_bg = scheme.tab_bar.active_tab.bg_color
    local active_fg = scheme.tab_bar.active_tab.fg_color
    local inactive_bg = scheme.tab_bar.inactive_tab.bg_color
    local inactive_fg = scheme.tab_bar.inactive_tab.fg_color
    local bg
    local fg
    local left_edge_bg
    local left_edge_fg
    local right_edge_bg
    local right_edge_fg
    local right_edge
    local left_edge
    if tab.is_active then
      bg = active_bg
      fg = active_fg
      left_edge_bg = active_bg
      left_edge_fg = inactive_bg
      left_edge = SOLID_LEFT_ALLOW
      right_edge_bg = inactive_bg
      right_edge_fg = active_bg
      right_edge = SOLID_LEFT_ALLOW
    else
      bg = inactive_bg
      fg = inactive_fg
      left_edge_bg = inactive_bg
      left_edge_fg = inactive_bg
      left_edge = " "
      right_edge_bg = inactive_bg
      right_edge_fg = inactive_fg
      right_edge = SOFT_LEFT_ALLOW
    end

    local title_prefix = " " .. tab.tab_index .. ":"
    local pane = tab.active_pane
    if pane.domain_name then
      title_prefix = title_prefix .. "(" .. pane.domain_name .. "):"
    end
    local title = wezterm.truncate_right(title_prefix .. tab_title(tab), max_width - 3) .. " "

    return {
      { Background = { Color = left_edge_bg } },
      { Foreground = { Color = left_edge_fg } },
      { Text = left_edge },
      { Background = { Color = bg } },
      { Foreground = { Color = fg } },
      { Text = title },
      { Background = { Color = right_edge_bg } },
      { Foreground = { Color = right_edge_fg } },
      { Text = right_edge },
    }
  end)

  config.window_frame = {
    active_titlebar_fg = "hsla(0 0% 0% 0%)",
    inactive_titlebar_fg = "hsla(0 0% 0% 0%)",
    active_titlebar_bg = "hsla(0 0% 0% 0%)",
    inactive_titlebar_bg = "hsla(0 0% 0% 0%)",
    active_titlebar_border_bottom = "hsla(0 0% 0% 0%)",
    inactive_titlebar_border_bottom = "hsla(0 0% 0% 0%)",
    button_fg = "hsla(0 0% 0% 0%)",
    button_bg = "hsla(0 0% 0% 0%)",
    border_bottom_color = "hsla(0 0% 0% 0%)",
  }
  config.integrated_title_button_color = "Auto"
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  if utils.is_mac then
    config.integrated_title_buttons = {"Close", "Hide", "Maximize"}
    config.integrated_title_button_alignment = "Left"
    config.tab_bar_style ={
      window_hide = wezterm.format({
        { Background = { Color = transparent_bg } },
        { Foreground = { Color = "#FFBD44" } },
        { Text = " " .. wezterm.nerdfonts.md_circle_medium .. "  " }
      }),
      window_hide_hover = wezterm.format({
        { Background = { Color = transparent_bg } },
        { Foreground = { Color = "#FFBD44" } },
        { Text = " " .. wezterm.nerdfonts.md_minus_circle .. "  " }
      }),
      window_maximize = wezterm.format({
        { Background = { Color = transparent_bg } },
        { Foreground = { Color = "#00CA4E" } },
        { Text = " " .. wezterm.nerdfonts.md_circle_medium .. "  " }
      }),
      window_maximize_hover = wezterm.format({
        { Background = { Color = transparent_bg } },
        { Foreground = { Color = "#00CA4E" } },
        { Text = " " .. wezterm.nerdfonts.md_share_circle .. "  " }
      }),
      window_close = wezterm.format({
        { Background = { Color = transparent_bg } },
        { Foreground = { Color = "#FF605C" } },
        { Text = " " .. wezterm.nerdfonts.md_circle_medium .. "  " }
      }),
      window_close_hover = wezterm.format({
        { Background = { Color = transparent_bg } },
        { Foreground = { Color = "#FF605C" } },
        { Text = " " .. wezterm.nerdfonts.md_close_circle .. "  " }
      })
    }
  else
    config.integrated_title_buttons = {"Hide", "Maximize", "Close"}
    config.integrated_title_button_alignment = "Right"
    config.tab_bar_style ={
      window_hide = " " .. wezterm.nerdfonts.fa_window_minimize .. "  ",
      window_hide_hover = " " .. wezterm.nerdfonts.fa_window_minimize .. "  ",
      window_maximize = " " .. wezterm.nerdfonts.fa_window_maximize .. "  ",
      window_maximize_hover = " " .. wezterm.nerdfonts.fa_window_maximize .. "  ",
      window_close = " " .. wezterm.nerdfonts.cod_chrome_close .. "  ",
      window_close_hover = wezterm.format({
        { Background = { Color = "red" } },
        { Foreground = { Color = "white" } },
        { Text = " " .. wezterm.nerdfonts.cod_chrome_close .. "  " }
      })
    }
  end

  config.window_padding = {
    left = "0.5cell",
    right = "0.5cell",
    top = "0.125cell",
    bottom = "0cell"
  }

  config.show_new_tab_button_in_tab_bar = false
  config.tab_bar_at_bottom = true

  config.colors = scheme
  config.window_background_opacity = 1
  config.text_background_opacity = 0.7
  --if utils.is_win then
  --  config.win32_system_backdrop = "Acrylic"
  --end

  config.inactive_pane_hsb = {
    hue = 1.0, saturation = 1.0, brightness = 0.7
  }

  config.font_shaper = "Harfbuzz"
  config.harfbuzz_features = {}
  local jpfont
  if utils.is_win then
    jpfont = "BIZ UDゴシック"
  else
    jpfont = "PlemolJP Console NF"
  end
  config.font_size = 10.0
  config.font = wezterm.font_with_fallback({
    {
      --family = "Monaspace Neon",
      family = "Monaspace Argon",
      --family = "Monaspace Xenon",
      --family = "Monaspace Radon",
      --family = "Monaspace Krypton",
      weight="Regular",
      harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss08" },
    },
    "Symbols Nerd Font Mono",
    { family = jpfont, assume_emoji_presentation=false },
    "Noto Color Emoji",
  })
  config.font_rules = {
    -- for comment in code (italic)
    {
      intensity = "Normal",
      italic = true,
      font = wezterm.font_with_fallback({
        {
          family = "Monaspace Radon",
          weight="ExtraLight",
          stretch="Normal",
          style="Normal",
          harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss08" },
        },
        { family = jpfont, weight="Regular", italic=true, assume_emoji_presentation=false },
      })
    },
    -- for highlighted text in code (bold)
    {
      intensity = "Bold",
      italic = false,
      font = wezterm.font_with_fallback({
        {
          family = "Monaspace Krypton",
          weight="Light",
          stretch="Normal",
          style="Normal",
          harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss08" },
        },
        { family = jpfont, weight="ExtraLight", italic=true, assume_emoji_presentation=false },
      })
    },
    -- bold-italic
    {
      intensity = "Bold",
      italic = true,
      font = wezterm.font_with_fallback({
        {
          family = "Monaspace Radon",
          weight="Light",
          stretch="Normal",
          style="Normal",
          harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss08" },
        },
        { family = jpfont, weight="Regular", italic=true, assume_emoji_presentation=false },
      })
    },
  }

  config.freetype_interpreter_version = 40
  config.freetype_load_flags = "NO_HINTING|NO_BITMAP|MONOCHROME"
  config.freetype_load_target = "Light"
  config.freetype_render_target = "Normal"

  return config
end

return M
