return function()
  local icons = {
    lines = require("configs.ui.icons").get("lines"),
  }

  ---@type snacks.Config
  local snacks_conf = {
  ---
  --- bigfile
  ---
    bigfile = {
      enabled = true,
      notify = true,
      ---@param ctx {buf: number, ft:string}
      setup = function(ctx)
        if vim.fn.exists(":NoMatchParen") ~= 0 then
          vim.cmd([[NoMatchParen]])
        end
        vim.b.minianimate_disable = true
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            vim.bo[ctx.buf].syntax = ctx.ft
          end
        end)
        vim.g.bigfile_detected = true
      end,
    },
  ---
  --- inline image viewer
  ---
    image = { enabled = true },
  ---
  --- visualize indent, blank and scope chunk
  ---
    indent = {
      indent = {
        priority = 1,
        enabled = not vim.g.bigfile_detected,
        char = icons.lines.Vbar,
        only_scope = false,
        only_current = false,
        hl = "SnacksIndent", ---@type string|string[]
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
      },
      -- animate scopes. Enabled by default for Neovim >= 0.10
      -- Works on older versions but has to trigger redraws during animation.
      ---@class snacks.indent.animate: snacks.animate.Config
      ---@field enabled? boolean
      --- * out: animate outwards from the cursor
      --- * up: animate upwards from the cursor
      --- * down: animate downwards from the cursor
      --- * up_down: animate up or down based on the cursor position
      ---@field style? "out"|"up_down"|"down"|"up"
      animate = {
        enabled = not vim.g.bigfile_detected and vim.fn.has("nvim-0.10") == 1,
        style = "out",
        easing = "linear",
        duration = {
          step = 20, -- ms per step
          total = 500, -- maximum duration
        },
      },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = not vim.g.bigfile_detected, -- enable highlighting the current scope
        priority = 200,
        char = icons.lines.Vbar,
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = not vim.g.bigfile_detected,
        -- only show chunk scopes in the current window
        only_current = false,
        priority = 200,
        hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        char = {
          cornor_top= icons.lines.RoundedLeftTop,
          cornor_bottom = icons.lines.RoundedLeftBottom,
          horizontal = icons.lines.Hbar,
          vertical = icons.lines.Vbar,
          arrow = icons.lines.RightArrow,
        },
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
      end,
    },
  ---
  --- picker palette
  ---
    picker = { enabled = true },
  }

  require("snacks").setup(snacks_conf)
end
