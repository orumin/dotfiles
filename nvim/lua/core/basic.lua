local nvim_cache_dir = vim.env.XDG_CACHE_HOME .. '/nvim'
local options = {
  hidden = true, -- open file ignoring modify files
  autoread = true, -- reload file if file is editted by external system

  -- indent, tabwidth
  shiftwidth = 4,
  tabstop = 4,
  softtabstop = 4,
  expandtab = true,
  modeline = true,
  modelines = 5,

  -- avoid insert newline at end of file
  -- WARN: POSIX require newline character at EOF for plain text.
  --
  -- binary = true,
  -- eol = false,
  fixeol = false,

  -- setting search
  hlsearch = true, -- hilighting
  incsearch = true, -- increment search
  ignorecase = true, -- no differentiate char case
  smartcase = true, -- differentiate char case if search by mixed case word
  wrapscan = true,

  -- setting edit
  backspace = 'indent,eol,start',
  showmatch = true,
  smartindent = true,
  --iminsert=2 -- disable IME when escape from insert mode
  -- spell
  spelllang = 'en_us,cjk',

  -- setting display
  ruler = true,
  showcmd = true,
  number = true,
  wrap = false,
  list = true, -- display invisible character
  listchars = 'tab:▸ ,space:⋅,eol:↲,extends:❯,precedes:❮',
  matchtime = 3,
  laststatus = 2,
  cmdheight = 2,
  wildmenu = true,
  -- https://github.com/neovim/neovim/issues/6041
  guicursor = "",

  -- copy to clipboard
  clipboard = 'unnamed',

  -- disable mouse
  mouse = "",

  -- disable changing current director automatically
  autochdir = false,

  -- backup directories
  undodir = nvim_cache_dir .. '/undo',
  backupdir = nvim_cache_dir .. '/backup',
  directory = nvim_cache_dir .. '/swp',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
