return {
---------------------------------------------------------------
-- completion
---------------------------------------------------------------
  -- nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "dmitmel/cmp-cmdline-history" },
      { "petertriho/cmp-git" },
      { "octaltree/cmp-look" },
      {
        "zbirenbaum/copilot-cmp",
        config = function ()
          require("copilot_cmp").setup()
        end
      },
      {
        "aspeddro/cmp-pandoc.nvim",
        dependencies = {
          { "nvim-lua/plenary.nvim" }
        }
      },
      { "kdheepak/cmp-latex-symbols" },
      -- snippets support
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "L3MON4D3/cmp-luasnip-choice" },
      -- skk
      {
        "rinx/cmp-skkeleton",
        dependencies = {
          { "vim-skk/skkeleton" }
        },
      },
    },
    config = require("completion.nvim-cmp")
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

