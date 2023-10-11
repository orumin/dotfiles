local settings = require("configs.global_settings")
local M = {}
local G = {}
local uv = vim.uv

function M.setting_global()
  G.pr_info = function (msg, opts)
    vim.notify(msg, vim.log.levels.INFO, opts)
  end
  G.pr_warn = function (msg, opts)
    vim.notify(msg, vim.log.levels.WARN, opts)
  end
  G.pr_error = function (msg, opts)
    vim.notify(msg, vim.log.levels.ERROR, opts)
  end

  G.uname = uv.os_uname()

  G.gui_running = vim.fn.has("gui_running") == 1
  G.is_win = G.uname.sysname == "Windows" or G.uname.sysname == "Windows_NT"
  G.is_mac = G.uname.sysname == "Darwin"
  G.is_linux = G.uname.sysname == "Linux"
  G.is_wsl = G.is_linux and string.find(G.uname.release, "microsoft") ~= nil
  G.path_sep = G.is_win and "\\" or "/"
  G.home = G.is_win and vim.env.USERPROFILE or vim.env.HOME
  if vim.env.XDG_CONFIG_HOME then
    G.config_home = vim.env.XDG_CONFIG_HOME
  else
    G.config_home = G.home .. G.path_sep .. ".config"
  end

  G.nvim_cache_dir = vim.fn.stdpath("cache")
  G.nvim_config_dir = vim.fn.stdpath("config")
  G.nvim_data_dir = vim.fn.stdpath("data")
  G.nvim_state_dir = vim.fn.stdpath("state")
  G.plugin_config_dir = G.nvim_config_dir .. G.path_sep .. "lua" .. G.path_sep .. "configs" .. G.path_sep .. "plugin"

  G.homedir = uv.os_homedir()

  if vim.fn.executable("w3m") == 1 then
    G.cli_browser = "w3m"
  elseif vim.fn.executable("lynx") == 1 then
    G.cli_browser = "lynx"
  elseif vim.fn.executable("links") == 1 then
    G.cli_browser = "links"
  end

  if vim.fn.executable("carbonyl") == 1 then
    G.cli_rich_browser = "carbonyl"
  elseif vim.fn.executable("browsh") == 1 then
    G.cli_rich_browser = "browsh"
  end

  G.browser = vim.env.BROWSER and vim.env.BROWSER or "vivaldi"
end

function M.globals()
  return G
end

---@return string
function M.get_root()
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
end

---@return table?
function M.get_palette()
  local color = require("core.color")
  local ok, catppuccin_palettes
  if color.name:find("catppuccin") then
    ok, catppuccin_palettes = pcall(require, "catppuccin.palettes")
    if ok then
      return catppuccin_palettes.get_palette()
    end
  end
  return {
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
end

function M.setting_shell()
  if G.is_win then
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
end

function M.setting_clipboard()
  if vim.env.SSH_CONNECTION or vim.env.TMUX ~= nil then
    vim.g.clipboard = {
      name = "tmuxClipboard",
      copy = {
        ["+"] = "tmux load-buffer -",
        ["*"] = "tmux load-buffer -",
      },
      paste = {
        ["+"] = "tmux save-buffer -",
        ["*"] = "tmux save-buffer -",
      },
      cache_enabled = 1,
    }
  elseif G.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy", },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste", },
      cache_enabled = 0,
    }
  elseif G.is_win or G.is_wsl then
    if vim.fn.executable("win32yank") == 1 then
      vim.g.clipboard = {
        name = "win32yank-Clipboard",
        copy = {
          ["+"] = "win32yank.exe -i --crlf",
          ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
          ["+"] = "win32yank.exe -o --lf",
          ["*"] = "win32yank.exe -o --lf",
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
          ["+"] = pwsh .. ' -Command [Console]::Out.Write($(Get-Clipboard -Raw)).tostring().replace("`r", ""))',
          ["*"] = pwsh .. ' -Command [Console]::Out.Write($(Get-Clipboard -Raw)).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
      }
    end
  elseif vim.fn.executable("lemonade") == 1 then -- for SSH
    vim.g.clipboard = {
      name = "wl-Clipboard",
      copy = {
        ["+"] = "lemonade copy",
        ["*"] = "lemonade copy",
      },
      paste = {
        ["+"] = "lemonade paste",
        ["*"] = "lemonade paste",
      },
      cache_enabled = 0,
    }
  elseif vim.env.WAYLAND_DISPLAY ~= nil and
    vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") then -- for Wayland
    vim.g.clipboard = {
      name = "wl-Clipboard",
      copy = {
        ["+"] = "wl-copy --foreground --type text/plain",
        ["*"] = "wl-copy --foreground --type text/plain",
      },
      paste = {
        ["+"] = "wl-paste --no-newline",
        ["*"] = "wl-paste --no-newline",
      },
      cache_enabled = 0,
    }
  elseif vim.env.DISPLAY ~= nil and vim.fn.executable("xsel") then -- for X11
    vim.g.clipboard = {
      name = "xsel-Clipboard",
      copy = {
        ["+"] = "xsel --nodetach -i -b",
        ["*"] = "xsel --nodetach -i -b",
      },
      paste = {
        ["+"] = "xsel -o -b",
        ["*"] = "xsel -o -b",
      },
      cache_enabled = 0,
    }
  elseif vim.env.DISPLAY ~= nil and vim.fn.executable("xclip") then -- for X11
    vim.g.clipboard = {
      name = "xclip-Clipboard",
      copy = {
        ["+"] = "xclip -quiet -i -selection clipboard",
        ["*"] = "xclip -quiet -i -selection clipboard",
      },
      paste = {
        ["+"] = "xclip -o -selection -clipboard",
        ["*"] = "xclip -o -selection -clipboard",
      },
      cache_enabled = 0,
    }
  end
end

function M.open_float_term()
  local current_width=vim.api.nvim_win_get_width(0)
  local current_height=vim.api.nvim_win_get_height(0)
  local ratio = 0.8
  local width=math.ceil(current_width*ratio)
  local height=math.ceil(current_height*ratio)
  local col=math.ceil((current_width-width) / 2-1)
  local row=math.ceil((current_height-height) / 2-1)

  local opts = {
    border="rounded",
    width=width,
    height=height,
    relative='editor',
    col=col,
    row=row,
    style="minimal"
  }

  local bufnr = vim.api.nvim_create_buf(false, true)
  local winnr = vim.api.nvim_open_win(bufnr, true, opts)

  vim.wo[winnr].winblend = 0
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = "terminal"

  local chan = vim.api.nvim_open_term(bufnr, {})
  vim.fn.jobstart(vim.env.SHELL, {
    pty = 1,
    on_stdout = function (_, data, _)
      for _, d in ipairs(data) do
        vim.api.nvim_chan_send(chan, d .. "\r\n")
      end
    end
  })
end

M.setting_global()

return M
