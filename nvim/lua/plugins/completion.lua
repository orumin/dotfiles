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
    config = require("completion.copilot_conf")
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
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    keys = require("configs.keymap.copilot_chat"),
    config = require("completion.copilot_chat_conf"),
  }
}

