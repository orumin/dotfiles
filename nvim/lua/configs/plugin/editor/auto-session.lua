return function ()
  local utils = require("envutils")
  local G = utils:globals()
  require("auto-session").setup({
    log_level = "error",

    cwd_change_handling = {
      restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
      pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
      post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
        require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
      end,
    },
    auto_session_enable_last_session = false,
    auto_session_last_session_dir = utils:path_concat({G.nvim_data_dir, "last_session", ""}),
    auto_session_root_dir = utils:path_concat({G.nvim_data_dir, "sessions", ""}),
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil,
    auto_session_use_git_branch = nil,
    -- the configs below are lua only
    bypass_session_save_file_types = nil
  })
end
