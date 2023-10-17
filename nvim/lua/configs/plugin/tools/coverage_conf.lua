return function ()
  local utils = require("envutils")
  local palette = utils.get_palette()
  require("coverage").setup({
    commands = true, -- create commands
    highlights = {
      -- customize highlight groups created by the plugin
      covered = { fg = palette.green },   -- supports style, fg, bg, sp (see :h highlight-gui)
      uncovered = { fg = palette.red },
    },
    signs = {
      -- use your own highlight groups or text markers
      covered = { hl = "CoverageCovered", text = "▎" },
      uncovered = { hl = "CoverageUncovered", text = "▎" },
    },
    summary = {
      -- customize the summary pop-up
      min_coverage = 80.0,      -- minimum coverage threshold (used for highlighting)
    },
    lang = {
      -- customize language specific settings
    },
  })
end
