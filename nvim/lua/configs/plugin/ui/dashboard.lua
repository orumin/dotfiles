---@class buttonsVal
---@field type string
---@field val string
---@field on_press fun(): nil
---@field opts table

-- set menu
---@param button fun(sc: string, text: string, keybind: string?, keybind_opts: table?): buttonsVal
---@return buttonsVal[]
local function custom_buttons(button)
  return {
    button("e", "  New file", "<Cmd>ene <CR>"),
    button("f", "󰈞  Find file", "<Cmd>Telescope find_files<CR>"),
    button("r", "󰊄  Recently opened files", "<Cmd>Telescope oldfiles<CR>"),
--    button("SPC f r", "  Frecency/MRU"),
    button("g", "󰈬  Find word", "<Cmd>Telescope live_grep<CR>"),
--    button("SPC f m", "  Jump to bookmarks"),
--    button("SPC s l", "  Open last session"),
    button("q", "Quit NeoVim", "<Cmd>qa<CR>"),
  }
end

local custom_opts = {
  noautocmd = true
}

return function ()
  local utils = require("envutils")
  local G = utils:globals()
  local alpha = require("alpha")
  require("alpha.term")
  local dashboard = require("alpha.themes.dashboard")

  local command = utils:path_concat({G.nvim_config_dir, "assets", "logo", "hsd_with_text"})
  if vim.o.shell == "pwsh" or vim.o.shell == "powershell" then
    command = command .. ".ps1"
  else
    command = command .. ".sh"
  end

  vim.notify(command)

  --dashboard.section.header = custom_theme.header
  dashboard.section.terminal.command = command
  dashboard.section.terminal.width = 187
  dashboard.section.terminal.height = 30
  dashboard.section.terminal.opts.redraw = true
  dashboard.section.buttons.val = custom_buttons(dashboard.button)
  dashboard.section.footer.val = require("alpha.fortune")()

  dashboard.config.layout = {
    dashboard.section.terminal,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    dashboard.section.footer
  }

  for k, v in pairs(custom_opts) do
    dashboard.config.opts[k] = v
  end

  alpha.setup(dashboard.config)
end
