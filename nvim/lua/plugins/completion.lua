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
  }
}

