local settings = require("configs.global_settings")
local M = {}
local uv
if vim.uv then uv = vim.uv else uv = vim.loop end

function M.setting_global()
  _G.pr_error = function (msg, opts)
    vim.notify(msg, vim.log.levels.ERROR, opts)
  end

  _G.nnoremap = function (lhs, rhs)
    vim.keymap.set("n", lhs, rhs, {noremap = true, silent = true})
  end


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
  _G.plugin_config_dir = nvim_config_dir .. "/lua/configs/plugin"

  _G.homedir = uv.os_homedir()
end

---@return string
function M.get_root()
  local path = uv.fs_realpath(vim.api.nvim_buf_get_name(0))
  ---@type string[]
  local roots = {}
  if path ~= "" then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local root_dir = client.config.root_dir
      local workspace = client.config.workspace_folders
      local paths = root_dir and { root_dir } or
                    workspace and vim.tbl_map(function(ws)
                                                return vim.uri_to_fname(ws.uri) end,
                                              workspace) or
                    {}
      for _, p in ipairs(paths) do
        local r = uv.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  ---@type string?
  local root = roots[1]
  if not root then
    path = path == "" and uv.cwd() or vim.fs.dirname(path)
    ---@type string?
    root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or uv.cwd()
  end
  --@cast root string
  return root
end

---@return table?
function M.get_palette()
  local color = require("core.color")
  return color.name:find("catppuccin") and require("catppuccin.palettes").get_palette()
          or {
            rosewater = "#f5e0dc",
            flamingo =  "#f2cdcd",
            pink =      "#f5c2e7",
            mauve =     "#cba6f7",
            red =       "#f38ba8",
            maroon =    "#eba0ac",
            peach =     "#fab387",
            yellow =    "#f9e2af",
            green =     "#a6e3a1",
            teal =      "#94e2d5",
            sky =       "#89dceb",
            sapphire =  "#74c7ec",
            blue =      "#89b4fa",
            lavender =  "#b4befe",
            text =      "#cdd6f4",
            subtext1 =  "#bac2de",
            subtext0 =  "#a6adc8",
            overlay2 =  "#9399b2",
            overlay1 =  "#7f849c",
            overlay0 =  "#6c7086",
            surface2 =  "#585b70",
            surface1 =  "#45475a",
            surface0 =  "#313244",
            base =      "#1e1e2e",
            mantle =    "#181825",
            crust =     "#11111b",
          }
end

function M.disable_rtp_plugins ()
  local get_flag = function (name)
    return settings.disabled_rtp_plugins[name] and 1 or 0
  end
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
  vim.g.loaded_spellfile_plugin   = get_flag("spellfile")

  vim.g.loaded_man                = get_flag("man")

  -- disable load tutor plugin
  vim.g.loaded_tutor_mode_plugin  = get_flag("tutor")

  -- don't load tohtml.vim
  vim.g.loaded_2html_plugin       = get_flag("tohtml")

  -- netrw liststyle: https://medium.com/usevim/the-netrw-style-options-3ebe91d42456
  vim.g.loaded_netrwPlugin        = get_flag("netrwPlugin")
  --vim.g.netrw_liststyle           = 3

  -- don't use built-in matchit.vim and matchiparen.vim
  -- since the use of vim-matchup
  vim.g.loaded_matchit            = get_flag("matchit")
  vim.g.loaded_matchparen         = get_flag("matchiparen")

  -- don't load plugin for archive format file
  -- (related to checking files inside archive)
  vim.g.loaded_gzip               = get_flag("gzip")
  vim.g.loaded_tarPlugin          = get_flag("tarPlugin")
  vim.g.loaded_zipPlugin          = get_flag("zipPlugin")

  vim.g.skip_loading_mswin        = 1

  vim.g.loaded_shada_plugin       = get_flag("shada")
  -- disable remote plugins
  vim.g.loaded_remote_plugins     = get_flag("rplugin")
end

M.setting_global()

return M
