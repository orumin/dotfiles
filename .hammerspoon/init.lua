local function wez_resize(wez)
  if not wez then return end
  local window = wez:focusedWindow()
  local f = window:frame()
  local max = window:screen():frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h * 0.7
  window:setFrame(f)
end

hs.hotkey.bind({"ctrl"}, ";", function()
  local wez = hs.application.get("com.github.wez.wezterm")
  if not wez then
    hs.application.launchOrFocus(os.getenv("HOME") .. "/working/wezterm/target/release/wezterm-gui")
    wez = hs.application.get("com.github.wez.wezterm")
    wez_resize(wez)
  else
    if wez:isFrontmost() then
      wez:hide()
    else
      wez:activate()
      wez_resize(wez)
    end
  end
end)
