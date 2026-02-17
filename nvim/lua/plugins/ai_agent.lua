return {
---------------------------------------------------------------
-- generative AI agent
---------------------------------------------------------------
  -- Copilot (trial)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = require("completion.copilot_conf").setup
  },
  {
    "folke/sidekick.nvim",
    opts = {},
    keys = require("configs.keymap.sidekick"),
  }
--  {
--    "CopilotC-Nvim/CopilotChat.nvim",
--    cmd = {
--      "CopilotChatOpen",
--      "CopilotChatClose",
--      "CopilotChatToggle",
--      "CopilotChatReset",
--      "CopilotChatDebugInfo",
--    },
--    dependencies = {
--      { "zbirenbaum/copilot.lua" },
--      { "nvim-lua/plenary.nvim" },
--    },
--    -- TODO: use 'build' for only macOS or Linux
--    build = "make tiktoken",
--    branch = "main",
--    keys = require("configs.keymap.copilot_chat"),
--    config = require("completion.copilot_chat_conf"),
--  }

}
