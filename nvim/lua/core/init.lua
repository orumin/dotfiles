local M = {}

local function disable_rtp_plugins()
  local configs = require("configs")
  local get_flag = function (name)
    return configs.disabled_rtp_plugins[name] and 1 or nil
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

local function setting_shell()
  local configs = require("configs")
  local G = require("envutils"):globals()
  if G.is_win then
    if not (vim.fn.executable("pwsh") == 1 or vim.fn.executable("powershell") == 1) then
      vim.notify(
        [[
  Failed to setup shell configuration

  PowerShell is either not installe, missing from PATH environment, or not executable;
  cmd.exe will be used instead for `:!`

  You're recommended to install PowerShell for better experience.]],
        vim.log.levels.WARN,
        { title = "[core] Runtime Warning" })
      return
    end

    local basecmd = "-NoLogo -ExecutionPolicy RemoteSigned"
    local ctrlcmd = "-Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8"
    vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
    vim.o.shellcmdflag = string.format("%s %s;", basecmd, ctrlcmd)
    vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
    vim.o.shellquote = nil
    vim.o.shellxquote = nil
  else
    vim.o.shell = configs.shell
  end
end

local function setting_clipboard()
  local G = require("envutils"):globals()
  if vim.env.SSH_CONNECTION and vim.env.TMUX ~= nil and not G.is_headless then
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
      name = "lemonadeClipboard",
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
  elseif G.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy", },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste", },
      cache_enabled = 0,
    }
  elseif G.is_win or G.is_wsl then
    if vim.fn.executable("win32yank.exe") == 1 then
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
        (vim.fn.executable("pwsh") == 1)
        and "pwsh.exe"
        or "powershell.exe"
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
end


M.init = function ()
  vim.env.IN_NVIM = "1"
  --require("setup_profiler").init()
  vim.loader.enable()

  if vim.g.vscode then
    return
  end

  -- disable rtp plugins
  disable_rtp_plugins()
  -- disable providers
  vim.g.loaded_python3_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_node_provider = 0

  setting_clipboard()
  setting_shell()

  vim.g.mapleader = require("configs").mapleader

  local utils = require("envutils")
  local G = utils:globals()

  -- font for GUI client
  if G.is_win then
    vim.opt.guifont = "Monaspace Argon,Symbols Nerd Font Mono,BIZ UDゴシック,Noto Color Emoji:h10:#h-slight"
  else
    vim.opt.guifont = "Monaspace Argon,Symbols Nerd Font Mono,PlemolJP Console NF,Noto Color Emoji:h10:#h-slight"
  end
  -- backup directories
  vim.opt.undofile = true
  vim.opt.undodir = utils:path_concat({G.nvim_cache_dir, 'undo'})
  vim.opt.backupdir = utils:path_concat({G.nvim_cache_dir, 'backup'})
  vim.opt.directory = utils:path_concat({G.nvim_cache_dir, 'swp'})

  -- copy to clipboard
  if vim.g.clipboard then
    vim.opt.clipboard = "unnamedplus"
  end

  -- enable mouse
  vim.opt.mouse = "a"

  -- disable changing current director automatically
  vim.opt.autochdir = false

  -- spell
  vim.opt.spelllang = {"en_us", "cjk"}

  -- chars
  -- NOTE: listchars setting in 'nvim-listchars'
  vim.opt.backspace = {"indent", "eol", "start"}

  -- fold
  vim.opt.foldenable = true
  vim.opt.foldlevelstart = 99

  -- set ambiwidth size (single or double)
  vim.opt.ambiwidth="single"

  vim.opt.autoread = true -- reload file if file is editted by external system

  -- indent, tabwidth
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.opt.expandtab = true

  -- avoid insert newline at end of file
  -- WARN: POSIX require newline character at EOF for plain text.
  --
  -- binary = true,
  -- eol = false,
  vim.opt.fixeol = false

  -- setting edit
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.breakindent = true

  vim.opt.number = true
  vim.opt.wrap = false

  -- Default splitting will cause your main splits to jump when opening an edgebar
  -- To prevent this, set `splitkeep` to either `screen` or `topline`
  vim.opt.splitkeep = "screen"

  -- rShaDa
  --vim.o.shada = ""
end

M.finalize = function ()
  vim.opt.pumheight = 20
  --vim.o.shada = vim.o.shada

  -- setting search
  vim.opt.hlsearch = true -- hilighting
  vim.opt.incsearch = true -- increment search
  vim.opt.ignorecase = true -- no differentiate char case
  vim.opt.smartcase = true -- differentiate char case if search by mixed case word
  vim.opt.wrapscan = true
  vim.opt.showmatch = true

  vim.opt.ruler = true
  vim.opt.laststatus = 3
  vim.opt.cmdheight = 0
  vim.opt.splitkeep = "screen"

  vim.opt.updatetime = 400
  -- for which-key.nvim
  vim.opt.timeout = true
  vim.opt.timeoutlen = 500

  -- popup menu transparency
  vim.opt.pumblend = 15
  -- color
  vim.opt.termguicolors = true
end

return M
