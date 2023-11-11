local configs = require("configs")

--###############################################################
-- remove trailing spaces on save
--###############################################################
local trailingsp_augroup = vim.api.nvim_create_augroup('trailingSpace', { clear = true })
if configs.remove_trailing_space then
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = trailingsp_augroup,
    pattern = '',
    command = ":%s/\\s\\+$//e"
  })
end

local tw_augroup = vim.api.nvim_create_augroup('setTextwidth', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = tw_augroup,
  pattern = { 'text', 'nroff' },
  callback = function()
    vim.bo.textwidth = 78
  end
})

local indent_augroup = vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = indent_augroup,
  pattern = {'ansible', 'cmake', 'lua', 'yaml'},
  callback = function()
    vim.bo.shiftwidth     = 2
    vim.bo.tabstop        = 2
    vim.bo.softtabstop    = 2
    vim.bo.expandtab      = true
  end
})

--###############################################################
-- Search document by cword
--###############################################################
local cwordprg_augroup = vim.api.nvim_create_augroup("overrideKeywordprg", {clear = true})
-- override keywordprg to man command
vim.api.nvim_create_autocmd({'FileType'}, {
  group = cwordprg_augroup,
  pattern = {"c", "cpp", "fish", "help", "man", "objc", "objcpp", "sh", "tmux", "toggleterm", "vim", "zsh"},
  callback = function (ev)
    vim.keymap.set("n", "K", function()
      local cword = vim.fn.expand("<cword>")
      if ev.match == "vim" or ev.match == "help" then
        vim.cmd.help(cword)
      else
        vim.cmd(vim.o.keywordprg .. " " .. cword)
      end
    end, { buffer = ev.buf, desc = "search document by cword" })
  end

})

--###############################################################
-- Terminal
--###############################################################
-- NeoVim built-in Terminal
local term_augroup = vim.api.nvim_create_augroup("terminalConfig", {clear = true})
vim.api.nvim_create_autocmd('TermOpen', {
  group = term_augroup,
  callback = function()
    vim.wo.listchars = ''
    vim.wo.number = false
    vim.wo.cursorline = false
    vim.wo.relativenumber = false
  end
})

--vim.api.nvim_create_autocmd('TermOpen', {
--  group = term_augroup,
--  pattern = '',
--  command = 'startinsert'
--})

--###############################################################
-- show tips on entering nvim
--###############################################################
local vimtip_augroup = vim.api.nvim_create_augroup("vimTip", {clear = true})
vim.api.nvim_create_autocmd("VimEnter", {
  group = vimtip_augroup,
  callback = function ()
    vim.system({ "curl", "https://vtip.43z.one" }, nil,
      function(obj)
        local res = obj.stdout
        if not obj.code then
          res = "Error fetching tip: " .. res
        end
        vim.notify(res, 2, { title = "Tip!" })
      end
    )
  end
})
----###############################################################
---- auto toggle Neo-Tree
----###############################################################
--local auneotree = vim.api.nvim_create_augroup("AutoToggleNeoTree", {clear = true})
--vim.api.nvim_create_autocmd("VimEnter", {
--  group = auneotree,
--  callback = function ()
--    vim.cmd("Neotree")
--    vim.cmd("wincmd p")
--  end
--})
