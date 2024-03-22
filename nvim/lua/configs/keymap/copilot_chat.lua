return {
  -- Code related commands
  { "<leader>cce", "<Cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
  { "<leader>cct", "<Cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
  { "<leader>ccr", "<Cmd>CopilotChatReview<CR>", desc = "CopilotChat - Review code" },
  { "<leader>ccR", "<Cmd>CopilotChatRefactor<CR>", desc = "CopilotChat - Refactor code" },
  { "<leader>ccn", "<Cmd>CopilotChatBetterNamings<CR>", desc = "CopilotChat - Better Naming" },
  -- Chat with Copilot in visual mode
  { "<leader>ccv", ":CopilotChatVisual ", mode = "x", desc = "CopilotChat - Chat with vertical split" },
  { "<leader>ccx", ":CopilotChatInline<CR>", mode = "x", desc = "CopilotChat - Inline chat" },
  -- Custom input for CopilotChat
  { "<leader>cci", function ()
    local input = vim.fn.input("Ask Copilot: ")
    if input ~= "" then
      vim.cmd("CopilotChat " .. input)
    end
  end, desc = "CopilotChat - Ask input" },
  -- Generate commit message based on the git diff
  { "<leader>ccm", "<Cmd>CopilotChatCommit<CR>", desc = "CopilotChat - Generate commit message for all changes" },
  { "<leader>ccM", "<Cmd>CopilotChatCommitStaged<CR>", desc = "CopilotChat - Generate commit message for staged changes" },
  -- Quick chat with Copilot
  { "<leader>ccq", function ()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      vim.cmd("CopilotChatBuffer " .. input)
    end
  end, desc = "CopilotChat - Quick chat" },
  -- Debug
  { "<leader>ccd", "<Cmd>CopilotChatDebugInfo<CR>", desc = "CopilotChat - Debug Info" },
  -- Fix the issue with diagnostic
  { "<leader>ccf", "<Cmd>CopilotChatFixDiagnostic<CR>", desc = "CopilotChat - Fix Diagnostic" },
  -- Clear buffer and chat history
  { "<leader>ccl", "<Cmd>CopilotChatReset<CR>", desc = "CopilotChat - Clear buffer and chat history" },
--  -- Toggle Copilot Chat Vsplit
--  { "<leader>ccv", "<Cmd>CopilotChatToggle<CR>", desc = "CopilotChat - Toggle Vsplit" },
  -- Show help actions with telescope
  { "<leader>cch", function ()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
  end, desc = "CopilotChat - Help actions" }, -- show help actions with telescope
  { "<leader>ccp", function ()
    local actions = require("CopilotChat.actions")
    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
  end, desc = "CopilotChat - Help actions" }, -- show prompts actions with telescope
  { "<leader>ccp", ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions())<CR>",
  desc = "CopilotChat - Prompt actions" },
}
