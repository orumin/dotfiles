local M = {}

-- set header
M.header = {
  [[                                  __]],
  [[     ___     ___    ___   __  __ /\_\    ___ ___]],
  [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
  [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
  [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

---@class buttonsVal
---@field type string
---@field val string
---@field on_press fun(): nil
---@field opts table

-- set menu
---@param button fun(sc: string, text: string, keybind: string?, keybind_opts: table?): buttonsVal
---@return buttonsVal[]
M.buttons = function(button)
  return {
    button("e", "  New file", "<Cmd>ene <CR>"),
    button("f", "󰈞  Find file", "<Cmd>Telescope find_files<CR>"),
    button("r", "󰊄  Recently opened files", "<Cmd>Telescope oldfiles<CR>"),
--    button("SPC f r", "  Frecency/MRU"),
    button("g", "󰈬  Find word", "<Cmd>Telescope live_grep<CR>"),
--    button("SPC f m", "  Jump to bookmarks"),
--    button("SPC s l", "  Open last session"),
    button("q", "Quit NeoVIM", "<Cmd>qa<CR>"),
  }
end

return M