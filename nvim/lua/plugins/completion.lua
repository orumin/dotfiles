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
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    event = "VeryLazy",
    build = function ()
      local scoop_path = os.getenv("SCOOP")
      local utils = require("envutils")
      if utils:globals().is_win then
        if scoop_path and vim.fn.executable("msys2.cmd") == 1 then
          local luasnip_install_dir = utils:path_convert(utils:path_concat({utils:globals().nvim_data_dir, "lazy", "LuaSnip"}))
          local msys_sys_path = utils:path_concat({scoop_path, "apps", "msys2", "current", "usr", "bin"}) .. utils:globals().path_sep
          local msys_path = utils:path_concat({scoop_path, "shims", "msys2.cmd"})
          vim.fn.system({msys_sys_path .. "pacman.exe", "--noconfirm", "-Syu"})
          vim.fn.system({msys_sys_path .. "pacman.exe", "--noconfirm", "-S",
            "git",
            "mingw-w64-ucrt-x86_64-luajit",
            "mingw-w64-ucrt-x86_64-make",
            "mingw-w64-ucrt-x86_64-gcc",
            "pkg-config",
          })
          local build_cmd = 'cd ' ..  luasnip_install_dir .. '; ' ..
                            'mingw32-make ' ..
                            'CC=gcc CFLAGS=$(pkg-config --cflags luajit) ' ..
                            'LDFLAGS=$(pkg-config --libs luajit) ' ..
                            'install_jsregexp'
          vim.notify(build_cmd)
          vim.fn.system({msys_path, '-mingw64', '-ucrt64', '-c', build_cmd})
        else
          vim.notify("msys2 is not installed yet. do 'scoop install msys2'", vim.log.levels.WARN)
        end
      else
        os.execute("make install_jsregexp")
      end
    end
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

