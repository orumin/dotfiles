local settings = require("configs.global_settings")
local uv = vim.uv

---@diagnostic disable: duplicate-doc-field
---@class GlobalEnvs<T> { [string]: T }

---@class globals : GlobalEnvs<boolean>
---@field pr_info fun(msg: string, opts: table?)
---@field pr_warn fun(msg: string, opts: table?)
---@field pr_error fun(msg: string, opts: table?)
---@field is_headless boolean
---@field gui_running boolean
---@field is_win boolean
---@field is_mac boolean
---@field is_linux boolean
---@field is_wsl boolean
---@field path_sep string
---@field homedir string
---@field config_home string
---@field nvim_cache_dir string
---@field nvim_config_dir string
---@field nvim_data_dir string
---@field nvim_state_dir string
---@field plugin_config_dir string
---@field cli_browser string
---@field cli_rich_browser string
---@field browser string

---@class G : globals
---@field protected cached boolean

---@class utils : G
---@field private setting_global fun(utils)
---@field private setting_shell fun(utils)
---@field private setting_clipboard fun(utils)
---@field private disable_rtp_plugins fun()
---@field globals fun(utils): globals
---@field get_palette fun(): { [string]: string }
---@field get_root fun(): string
---@field get_keymap_opts fun(table): table
---@field setup fun(utils)

---@type utils
local M = {
  G = {
    globals = {
      pr_info = function (msg, opts)
        vim.notify(msg, vim.log.levels.INFO, opts)
      end,

      pr_warn = function (msg, opts)
        vim.notify(msg, vim.log.levels.WARN, opts)
      end,

      pr_error = function (msg, opts)
        vim.notify(msg, vim.log.levels.ERROR, opts)
      end
    },
    cached = false
  },

  setting_global = function (self)
    local uname = uv.os_uname()

    local uis = vim.api.nvim_list_uis() or {}
    local n_ui = 0
    for _ in pairs(uis) do n_ui = n_ui + 1 end

    self.G.globals["is_headless"] = n_ui == 0
    self.G.globals["gui_running"] = vim.fn.has("gui_running") == 1
    self.G.globals["is_win"] = uname.sysname == "Windows" or uname.sysname == "Windows_NT"
    self.G.globals["is_mac"] = uname.sysname == "Darwin"
    self.G.globals["is_linux"] = uname.sysname == "Linux"
    self.G.globals["is_wsl"] = self.G.globals["is_linux"] and string.find(uname.release, "microsoft") ~= nil
    self.G.globals["path_sep"] = self.G.globals["is_win"] and "\\" or "/"
    self.G.globals["homedir"] = uv.os_homedir()
    if vim.env.XDG_CONFIG_HOME then
      self.G.globals["config_home"] = vim.env.XDG_CONFIG_HOME
    else
      self.G.globals["config_home"] = self.G.globals["homedir"] .. self.G.globals["path_sep"] .. ".config"
    end

    self.G.globals["nvim_cache_dir"] = vim.fn.stdpath("cache")
    self.G.globals["nvim_config_dir"] = vim.fn.stdpath("config")
    self.G.globals["nvim_data_dir"] = vim.fn.stdpath("data")
    self.G.globals["nvim_state_dir"] = vim.fn.stdpath("state")
    self.G.globals["plugin_config_dir"] = self.G.globals["nvim_config_dir"] .. self.G.globals["path_sep"] .. "lua" .. self.G.globals["path_sep"] .. "configs" .. self.G.globals["path_sep"] .. "plugin"

    if vim.fn.executable("w3m") == 1 then
      self.G.globals["cli_browser"] = "w3m"
    elseif vim.fn.executable("lynx") == 1 then
      self.G.globals["cli_browser"] = "lynx"
    elseif vim.fn.executable("links") == 1 then
      self.G.globals["cli_browser"] = "links"
    end

    if vim.fn.executable("carbonyl") == 1 then
      self.G.globals["cli_rich_browser"] = "carbonyl"
    elseif vim.fn.executable("browsh") == 1 then
      self.G.globals["cli_rich_browser"] = "browsh"
    end

    self.G.globals["browser"] = vim.env.BROWSER and vim.env.BROWSER or "vivaldi"
  end,

  globals = function (self)
    if not self.G.cached then
      self:setting_global()
    end
    return self.G.globals
  end,

  get_root = function ()
    local path = uv.fs_realpath(vim.api.nvim_buf_get_name(0))
    ---@type string[]
    local roots = {}
    if path and path ~= "" then
      for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        local root_dir = client.config.root_dir
        local workspace = client.config.workspace_folders
        local paths = root_dir and { root_dir } or
                      workspace and vim.tbl_map(function(ws)
                                                  return vim.uri_to_fname(ws.uri) end,
                                                workspace) or
                      {}
        for _, p in ipairs(paths) do
          local r = uv.fs_realpath(p)
          if r and path:find(r, 1, true) then
            roots[#roots + 1] = r
          end
        end
      end
    end
    ---@type string?
    local root = roots[1]
    if not root then
      if path == nil or path == "" then
        path = uv.cwd()
      else
        path = vim.fs.dirname(path)
      end
      ---@type string?
      root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
      root = root and vim.fs.dirname(root) or uv.cwd()
    end
    ---@cast root string
    return root
  end,

  get_palette = function ()
    local color = require("core.color")
    local ok, catppuccin_palettes
    local palette = nil
    if color.name:find("catppuccin") then
      ok, catppuccin_palettes = pcall(require, "catppuccin.palettes")
      if ok then
        palette = catppuccin_palettes.get_palette()
      end
    end

    if not palette then
      palette = {
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

    return palette
  end,

  get_keymap_opts = function(keys)
    local skip = { mode = true, ft = true, rhs = true, lhs = true }
    local ret = {}
    for k, v in pairs(keys) do
      if type(k) ~= "number" and not skip[k] then
        ret[k] = v
      end
    end
    return ret
  end,

  disable_rtp_plugins = function ()
    local get_flag = function (name)
      return settings.disabled_rtp_plugins[name] and 1 or nil
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
  end,

  setting_shell = function(self)
    if self:globals().is_win then
      if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
        vim.notify(
          [[
  Failed to setup shell configuration

  PowerShell is either not installe, missing from PATH environment, or not executable;
  cmd.exe will be used instead for `:!`

  You're recommended to install PowerShell for better experience.]],
          vim.log.levels.WARN,
          { title = "[lib] Runtime Warning" })
        return
      end

      local basecmd = "-NoLogo -MTA -ExecutionPolicy RemoteSigned"
      local ctrlcmd = "-Command [console]::InputEncoding = [console]::OutputEncoding = [System.text.Encoding]::UTF8"
      vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
      vim.o.shellcmdflag = string.format("%s %s;", basecmd, ctrlcmd)
      vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
      vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
      vim.o.shellquote = nil
      vim.o.shellxquote = nil
    else
      vim.o.shell = settings.shell
    end
  end,

  setting_clipboard = function (self)
    if vim.env.SSH_CONNECTION and vim.env.TMUX ~= nil then
      vim.g.clipboard = {
        name = "tmuxClipboard",
        copy = {
          ["+"] = {"tmux", "load-buffer", "-"},
          ["*"] = {"tmux", "load-buffer", "-"},
        },
        paste = {
          ["+"] = {"tmux", "save-buffer", "-"},
          ["*"] = {"tmux", "save-buffer", "-"},
        },
        cache_enabled = 1,
      }
    elseif vim.env.SSH_CONNECTION and vim.fn.executable("lemonade") == 1 then -- for SSH
      vim.g.clipboard = {
        name = "wl-Clipboard",
        copy = {
          ["+"] = {"lemonade", "copy"},
          ["*"] = {"lemonade", "copy"},
        },
        paste = {
          ["+"] = {"lemonade", "paste"},
          ["*"] = {"lemonade", "paste"},
        },
        cache_enabled = 0,
      }
    elseif self:globals().is_mac then
      vim.g.clipboard = {
        name = "macOS-clipboard",
        copy = { ["+"] = "pbcopy", ["*"] = "pbcopy", },
        paste = { ["+"] = "pbpaste", ["*"] = "pbpaste", },
        cache_enabled = 0,
      }
    elseif self:globals().is_win or self:globals().is_wsl then
      if vim.fn.executable("win32yank") == 1 then
        vim.g.clipboard = {
          name = "win32yank-Clipboard",
          copy = {
            ["+"] = {"win32yank.exe", "-i", "--crlf"},
            ["*"] = {"win32yank.exe", "-i", "--crlf"},
          },
          paste = {
            ["+"] = {"win32yank.exe", "-o", "--lf"},
            ["*"] = {"win32yank.exe", "-o", "--lf"},
          },
          cache_enabled = 0,
        }
      else
        local pwsh =
          vim.fn.executable("pwsh") == 1 and "pwsh.exe" or "powershell.exe"
        vim.g.clipboard = {
          name = "windows-Clipboard",
          copy = { ["+"] = "clip.exe", ["*"] = "clip.exe", },
          paste = {
            ["+"] = {pwsh, "-Command", '[Console]::Out.Write($(Get-Clipboard -Raw)).tostring().replace("`r", ""))'},
            ["*"] = {pwsh, "-Command", '[Console]::Out.Write($(Get-Clipboard -Raw)).tostring().replace("`r", ""))'},
          },
          cache_enabled = 0,
        }
      end
    elseif vim.env.WAYLAND_DISPLAY ~= nil and
      vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1 then -- for Wayland
      vim.g.clipboard = {
        name = "wl-Clipboard",
        copy = {
          ["+"] = {"wl-copy", "--type", "text/plain"},
          ["*"] = {"wl-copy", "--primary", "--type", "text/plain"},
        },
        paste = {
          ["+"] = {"wl-paste", "--no-newline"},
          ["*"] = {"wl-paste", "--no-newline", "--primary"},
        },
        cache_enabled = 1,
      }
    elseif vim.env.WAYLAND_DISPLAY ~= nil and
      vim.fn.executable("waycopy") == 1 and vim.fn.executable("waypaste") == 1 then
      vim.g.clipboard = {
        name = "way-Clipboard",
        copy = {
          ["+"] = {"waycopy", "-t", "text/plain"},
          ["*"] = {"waycopy", "-t", "text/plain"},
        },
        paste = {
          ["+"] = {"waypaste", "-t", "text/plain"},
          ["*"] = {"waypaste", "-t", "text/plain"},
        },
        cache_enabled = 1,
      }

    elseif vim.env.DISPLAY ~= nil and vim.fn.executable("xsel") == 1 then -- for X11
      vim.g.clipboard = {
        name = "xsel-Clipboard",
        copy = {
          ["+"] = {"xsel", "--nodetach", "-i", "-b"},
          ["*"] = {"xsel", "--nodetach", "-i", "-p"},
        },
        paste = {
          ["+"] = {"xsel", "-o", "-b"},
          ["*"] = {"xsel", "-o", "-p"},
        },
        cache_enabled = 1,
      }
    elseif vim.env.DISPLAY ~= nil and vim.fn.executable("xclip") == 1 then -- for X11
      vim.g.clipboard = {
        name = "xclip-Clipboard",
        copy = {
          ["+"] = {"xclip", "-quiet", "-i", "-selection", "clipboard"},
          ["*"] = {"xclip", "-quiet", "-i", "-selection", "primary"},
        },
        paste = {
          ["+"] = {"xclip", "-o", "-selection", "clipboard"},
          ["*"] = {"xclip", "-o", "-selection", "primary"},
        },
        cache_enabled = 1,
      }
    end
  end,

  --open_float_term = function()
  --  local current_width=vim.api.nvim_win_get_width(0)
  --  local current_height=vim.api.nvim_win_get_height(0)
  --  local ratio = 0.8
  --  local width=math.ceil(current_width*ratio)
  --  local height=math.ceil(current_height*ratio)
  --  local col=math.ceil((current_width-width) / 2-1)
  --  local row=math.ceil((current_height-height) / 2-1)
  --
  --  local opts = {
  --    border="rounded",
  --    width=width,
  --    height=height,
  --    relative='editor',
  --    col=col,
  --    row=row,
  --    style="minimal"
  --  }
  --
  --  local bufnr = vim.api.nvim_create_buf(false, true)
  --  local winnr = vim.api.nvim_open_win(bufnr, true, opts)
  --
  --  vim.wo[winnr].winblend = 0
  --  vim.bo[bufnr].bufhidden = "wipe"
  --  vim.bo[bufnr].filetype = "terminal"
  --
  --  local chan = vim.api.nvim_open_term(bufnr, {})
  --  vim.fn.jobstart(vim.env.SHELL, {
  --    pty = 1,
  --    on_stdout = function (_, data, _)
  --      for _, d in ipairs(data) do
  --        vim.api.nvim_chan_send(chan, d .. "\r\n")
  --      end
  --    end
  --  })
  --end,

  setup = function(self)
    self:disable_rtp_plugins()
    self:setting_shell()
    self:setting_clipboard()
  end
}

return M
