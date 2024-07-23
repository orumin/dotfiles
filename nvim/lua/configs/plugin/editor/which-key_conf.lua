return function ()
  local configs = require("configs")
  local icons = {
    ui = require("configs.ui.icons").get("ui"),
    misc = require("configs.ui.icons").get("misc")
  }
  require("which-key").setup({
    plugins = {
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = true,
        g = true
      }
    },
    icons = {
      breadcrumb = icons.ui.Separator,
      separator = icons.misc.Vbar,
      group = icons.misc.Add,
    },
    win = {
      border = "none",
      padding = { 1, 1, 1, 1 },
      wo = {
        winblend = configs.winblend,
      },
    }
  })
end
