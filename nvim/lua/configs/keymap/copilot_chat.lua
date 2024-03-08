return {
  { "<leader>ccb", ":CopilotChatBuffer ", desc = "CopilotChat - Chat with current buffer" },
  { "<leader>cce", "<Cmd>CopilotChatExplain<CR>", desc = "CopilotChat - Explain code" },
  { "<leader>cct", "<Cmd>CopilotChatTests<CR>", desc = "CopilotChat - Generate tests" },
  { "<leader>ccT", "<Cmd>CopilotChatVsplitToggle<CR>", desc = "CopilotChat - Toggle Vsplit" },
  { "<leader>ccv", ":CopilotChatVisual ", mode = "x", desc = "CopilotChat - Open in virtical split" },
  { "<leader>ccx", "<Cmd>CopilotChatInPlace<CR>", mode = "x", desc = "CopilotChat - Run in-place code" },
  { "<leader>ccf", "<Cmd>CopilotChatFixDiagnostic<CR>", desc = "CopilotChat - Fix diagnostic" },
  { "<leader>ccf", "<Cmd>CopilotChatReset<CR>", desc = "CopilotChat - Reset chat history and clear buffer" },
}
