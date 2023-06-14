local M = {}

function M.setting_global()
  _G.pr_error = function (msg, opts)
    vim.notify(msg, vim.log.levels.ERROR, opts)
  end

  _G.nnoremap = function (lhs, rhs)
    vim.keymap.set("n", lhs, rhs, {noremap = true, silent = true})
  end

  local uv
  if vim.uv then uv = vim.uv else uv = vim.loop end

  local uname = uv.os_uname()

  _G.gui_running = vim.fn.has("gui_running") == 1
  _G.is_win = uname.sysname == "Windows"
  _G.is_mac = uname.sysname == "Darwin"
  _G.is_linux = uname.sysname == "Linux"
  _G.is_wsl = is_linux and string.find(uname.release, "microsoft") ~= nil
  _G.path_sep = is_win and "\\" or "/"
  _G.home = is_win and vim.env.USERPROFILE or vim.env.HOME

  _G.nvim_config_dir = vim.fn.stdpath("config")
  _G.nvim_cache_dir = vim.fn.stdpath("cache")
  _G.plugin_config_dir = nvim_config_dir .. "/lua/plugins/config"

  _G.homedir = uv.os_homedir()
end


function M.disable_rtp_plugins ()
  --disable menu loading
  vim.g.did_install_default_menus = 1
  vim.g.did_install_syntax_menu   = 1

  vim.g.did_indent_on             = 1

  -- disable load after/ftplugin
  --vim.g.did_load_filetypes        = 1
  vim.g.did_load_ftplugin         = 1

  -- don't load native syntax completion
  vim.g.loaded_syntax_completion  = 1
  -- don't load sql omni completion
  vim.g.loaded_sql_completion  = 1
  -- don't load spell files
  vim.g.loaded_spellfile_plugin   = 1

  --vim.g.loaded_man                = 1

  -- disable load tutor plugin
  vim.g.loaded_tutor_mode_plugin  = 1

  -- don't load tohtml.vim
  vim.g.loaded_2html_plugin       = 1

  -- netrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
  --vim.g.loaded_netrwPlugin        = 1
  vim.g.netrw_liststyle           = 3

  -- don't use built-in matchit.vim and matchiparen.vim
  -- since the use of vim-matchup
  --vim.g.loaded_matchit            = 1
  --vim.g.loaded_matchparen         = 1

  -- don't load plugin for archive format file
  -- (related to checking files inside archive)
  vim.g.loaded_gzip               = 1
  vim.g.loaded_tar                = 1
  vim.g.loaded_tarPlugin          = 1
  vim.g.loaded_vimball            = 1
  vim.g.loaded_vimballPlugin      = 1
  vim.g.loaded_zip                = 1
  vim.g.loaded_zipPlugin          = 1

  vim.g.skip_loading_mswin        = 1

  vim.g.loaded_shada_plugin       = 1
  -- disable remote plugins
  vim.g.loaded_remote_plugins     = 1
end

M.setting_global()

return M
