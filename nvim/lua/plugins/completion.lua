return {
---------------------------------------------------------------
-- completion
---------------------------------------------------------------
  -- blink.cmp
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "giuxtaposition/blink-cmp-copilot", dependencies = "zbirenbaum/copilot.lua" },
    },
    version = "v0.*",
    config = require("completion.blink_cmp_conf")
  },
  -- Copilot (trial)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = require("completion.copilot_conf").setup
  },
  {
    "copilotlsp-nvim/copilot-lsp",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
    config = require("completion.copilot_conf").setup_lsp
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatReset",
      "CopilotChatDebugInfo",
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    -- TODO: use 'build' for only macOS or Linux
    build = "make tiktoken",
    branch = "main",
    keys = require("configs.keymap.copilot_chat"),
    config = require("completion.copilot_chat_conf"),
  }
}

