---@param wez userdata
---@param height_ratio number
local function wez_resize(wez, height_ratio)
  if not wez then return end
  if not height_ratio then return end
  local window = wez:focusedWindow()
  local f = window:frame()
  local screen = hs.mouse.getCurrentScreen()
  if not screen then
    print("hs.mouse.getCurrentScreen(): ", screen)
    return
  end
  local max = screen:frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h * height_ratio
  window:setFrame(f)
end

hs.hotkey.bind({"ctrl"}, ";", function()
  local wez = hs.application.get("com.github.wez.wezterm")
  if not wez then
    hs.application.launchOrFocus(os.getenv("HOME") .. "/working/wezterm/target/release/wezterm-gui")
    wez = hs.application.get("com.github.wez.wezterm")
    wez_resize(wez, 0.7)
  else
    if wez:isFrontmost() then
      wez:hide()
      --wez_resize(wez, 0.0)
    else
      wez:activate()
      wez_resize(wez, 0.7)
    end
  end
end)
