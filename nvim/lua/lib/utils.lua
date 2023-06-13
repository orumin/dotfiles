function  _G.pr_error(msg, opts)
  vim.notify(msg, vim.log.levels.ERROR, opts)
end

function _G.nnoremap (lhs, rhs)
  vim.keymap.set("n", lhs, rhs, {noremap = true, silent = true})
end

local uv
if vim.uv then uv = vim.uv else uv = vim.loop end

local uname = uv.os_uname()

_G.is_win = uname.sysname == "Windows"
_G.is_mac = uname.sysname == "Darwin"
_G.is_linux = uname.sysname == "Linux"
_G.is_wsl = is_linux and string.find(uname.release, "microsoft") ~= nil
_G.path_sep = is_win and "\\" or "/"

if vim.env.XDG_CACHE_HOME then
  _G.nvim_cache_dir = vim.env.XDG_CACHE_HOME .. path_sep .. 'nvim'
else
  _G.nvim_cache_dir = uv.os_homedir() .. path_sep .. '.cache' .. path_sep .. 'nvim'
end

_G.homedir = uv.os_homedir()
