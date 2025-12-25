---@source ./utils.lua
local utils = require("utils") --[[@as wezutils]]
---Pull in the wezterm API
---@module 'wezterm-types.lua.wezterm.types.wezterm'
local wezterm = require("wezterm")

---@class WezConfigGpu
local M = {}

---@param config Config
---@return Config config
M.setup = function (config)
  local frontend_configs = {
    ["low"] = {
      max_fps = 90,
      animation_fps = 90,
    },
    ["high"] = {
      max_fps = 165,
      animation_fps = 165,
    },
    ["software"] = {
      front_end="Software",
      animation_fps = 1
    }
  }

  local has_gpu = {}
  for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
    if gpu.device_type == "IntegratedGpu" then
      if not has_gpu["igpu"] then has_gpu["igpu"] = {} end
      has_gpu["igpu"][gpu.backend] = gpu
    elseif gpu.device_type == "DiscreteGpu" then
      if not has_gpu["dgpu"] then has_gpu["dgpu"] = {} end
      has_gpu["dgpu"][gpu.backend] = gpu
    end
  end

  ---@alias gpuBackend "Dx12" | "Gl" | "Vulkan"
  ---@type {[gpuBackend]: integer}
  local prefer_backend = {
    ["Gl"] = 255,
  }
  if utils.is_win then
    prefer_backend["Dx12"] = 50
    prefer_backend["Vulkan"] = 10
  else
    prefer_backend["Vulkan"] = 10
  end

  ---@param gpus {[gpuBackend]: table}
  local select_gpu = function(gpus)
    local sorted = {}
    for k,v in pairs(prefer_backend) do table.insert(sorted, { v, k }) end
    table.sort(sorted, function(a, b) return a[1] < b[1] end)

    for _, v in ipairs(sorted) do
      if gpus[v[2]] then
        return gpus[v[2]]
      end
    end
  end

  local prefer_webgpu = true
  if has_gpu["dgpu"] then
    for k, v in pairs(frontend_configs["high"]) do config[k] = v end
    -- don't change window opacity w/ Windows + GTX 1070Ti if WebGpu is used
    if prefer_webgpu and not utils.is_win then
      config.front_end = "WebGpu"
      config.webgpu_power_preference = "HighPerformance"
      config.webgpu_preferred_adapter = select_gpu(has_gpu["dgpu"])
    else
      config.front_end = "OpenGL"
    end
    --- missing 'mux_output_parser_coalesce_delay_ms' field in document https://wezterm.org/config/lua/config/index.html
    --- but introduced at 20220903-194523-3bb1ed61 https://wezterm.org/changelog.html#20220903-194523-3bb1ed61
    ---@diagnostic disable-next-line: inject-field
    config.mux_outpu_parser_coalesce_delay_ms = 0
  elseif has_gpu["igpu"] then
    for k, v in pairs(frontend_configs["low"]) do config[k] = v end
    if prefer_webgpu then
      config.front_end = "WebGpu"
      config.webgpu_power_preference = "LowPower"
      config.webgpu_preferred_adapter = select_gpu(has_gpu["igpu"])
    else
      config.front_end = "OpenGL"
    end
    ---@diagnostic disable-next-line: inject-field
    config.mux_output_parser_coalesce_delay_ms = 0
  else
    for k, v in pairs(frontend_configs["software"]) do config[k] = v end
  end

  return config
end

return M
