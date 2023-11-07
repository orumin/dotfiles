local M = {}

M.init = function ()
  vim.env.IN_NVIM = "1"
  --require("setup_profiler").init()
  vim.loader.enable()

  if vim.g.vscode then
    return
  end

  vim.g.loaded_python3_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_node_provider = 0

  vim.g.mapleader = require("configs").mapleader

  local utils = require("envutils")
  utils:setup()
  local G = utils:globals()

  -- font for GUI client
  vim.opt.guifont = "PlemolJP Console NF:h9"
  -- backup directories
  vim.opt.undofile = true
  vim.opt.undodir = utils:path_concat({G.nvim_cache_dir, 'undo'})
  vim.opt.backupdir = utils:path_concat({G.nvim_cache_dir, 'backup'})
  vim.opt.directory = utils:path_concat({G.nvim_cache_dir, 'swp'})

  -- copy to clipboard
  vim.opt.clipboard = "unnamedplus"

  -- enable mouse
  vim.opt.mouse = "a"

  -- disable changing current director automatically
  vim.opt.autochdir = false

  -- spell
  vim.opt.spelllang = {"en_us", "cjk"}

  vim.opt.backspace = {"indent", "eol", "start"}

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

  --listchars setting in 'nvim-listchars'
  vim.opt.number = true
  vim.opt.wrap = false

  vim.o.shada = ""
end

M.finalize = function ()
  vim.opt.pumheight = 20
  vim.o.shada = vim.o.shada

  -- setting search
  vim.opt.hlsearch = true -- hilighting
  vim.opt.incsearch = true -- increment search
  vim.opt.ignorecase = true -- no differentiate char case
  vim.opt.smartcase = true -- differentiate char case if search by mixed case word
  vim.opt.wrapscan = true
  vim.opt.showmatch = true

  vim.opt.ruler = true
  vim.opt.laststatus = 3

  vim.opt.timeout = false
  vim.opt.updatetime = 400

  -- popup menu transparency
  vim.opt.pumblend = 15
  -- color
  vim.opt.termguicolors = true
end

return M
