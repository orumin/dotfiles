local M = {}

M.init = function ()
  local should_profile = vim.env.NVIM_PROFILE ~= nil
  if should_profile then
    local nvim_data_dir = vim.fn.stdpath("data")
    local is_win = vim.fn.has("win32") == 1
    local profile_path = table.concat({nvim_data_dir, "lazy", "profile.nvim"}, is_win and "\\" or "/")
    vim.opt.runtimepath:append(profile_path)

    require("profile").instrument_autocmds()
    if should_profile == "start" then
      require("profile").start("*")
    else
      require("profile").instrument("*")
    end
  end

  local map = require("configs.keymap")["profile"][1]
  vim.keymap.set("", map[1], map[2], {desc = map.desc})
end

return M
