local utils = require("envutils")
local G = utils:globals()
local global_opts = {
  -- font for GUI client
  guifont = "PlemolJP Console NF:h9",
  -- backup directories
  undofile = true,
  undodir = utils:path_concat({G.nvim_cache_dir, 'undo'}),
  backupdir = utils:path_concat({G.nvim_cache_dir, 'backup'}),
  directory = utils:path_concat({G.nvim_cache_dir, 'swp'}),
  -- https://github.com/neovim/neovim/issues/6041
  guicursor = "",

  -- copy to clipboard
  clipboard = 'unnamed,unnamedplus',

  -- enable mouse
  mouse = "a",

  -- disable changing current director automatically
  autochdir = false,

  -- setting search
  hlsearch = true, -- hilighting
  incsearch = true, -- increment search
  ignorecase = true, -- no differentiate char case
  smartcase = true, -- differentiate char case if search by mixed case word
  wrapscan = true,
  showmatch = true,

  -- spell
  spelllang = 'en_us,cjk',

  backspace = 'indent,eol,start',

  foldenable = true,
  foldlevelstart = 99,
  ruler = true,
  modeline = true,
  modelines = 5,
  matchtime = 3,
  laststatus = 3,
  cmdheight = 2,
  wildmenu = true,
  showcmd = true,

  -- completion
  completeopt="menu,menuone,noselect",
  -- newline character
  fileformats="unix,dos,mac",
  -- set ambiwidth size (single or double)
  ambiwidth="single",

  -- popup menu transparency
  pumblend = 15,
}

local buffer_local_opts = {
  autoread = true, -- reload file if file is editted by external system

  -- indent, tabwidth
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,
  expandtab = true,

  -- avoid insert newline at end of file
  -- WARN: POSIX require newline character at EOF for plain text.
  --
  -- binary = true,
  -- eol = false,
  fixeol = false,

  --iminsert=2 -- disable IME when escape from insert mode

  -- setting edit
  autoindent = true,
  smartindent = true,
}

local window_local_opts = {
  list = true, -- display invisible character
  --listchars setting in 'nvim-listchars'
  breakindent = true,
  number = true,
  wrap = false,
}

for k, v in pairs(global_opts) do
  vim.o[k] = v
end

for k, v in pairs(window_local_opts) do
  --vim.wo[k] = v
  vim.opt[k] = v
end

for k, v in pairs(buffer_local_opts) do
  --vim.bo[k] = v
  vim.opt[k] = v
end

