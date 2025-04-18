return function ()
  if require("configs").use_copilot then
    ---@type copilot_config
    local opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        cmake = true,
        gitcommit = true,
        gitrebase = true,
        markdown = true,
        sh = function ()
          local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
          if fname and string.match(fname, '^%.env.*') then
            return false
          end
          return true
        end,
        lua = function ()
          if string.find(vim.api.nvim_buf_get_name(0), "dotfiles") then
            return true
          end
          return false
        end,
        ["*"] = false
      },
      --copilot_model = "gpt-35-turbo",
      server_opts_overrides = {
        trace = "verbose",
        settings = {
          advanced = {
            listCount = 10,
            inlineSuggestCount = 3,
          },
        },
      }
    }
    require("copilot").setup(opts)
  end
end
