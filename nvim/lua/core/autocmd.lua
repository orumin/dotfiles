local settings = require("configs.global_settings")
local utils = require("envutils")
local G = utils:globals()

--###############################################################
-- remove trailing spaces on save
--###############################################################
if settings.remove_trailing_space then
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
  })
end

vim.api.nvim_create_augroup('setTextwidth', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'setTextwidth',
  pattern = { 'text', 'nroff' },
  callback = function()
    vim.bo.textwidth = 78
  end
})

vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'setIndent',
  pattern = {'ansible', 'cmake', 'lua', 'yaml'},
  callback = function()
    vim.bo.shiftwidth     = 2
    vim.bo.tabstop        = 2
    vim.bo.softtabstop    = 2
    vim.bo.expandtab      = true
  end
})

--###############################################################
-- file type
--###############################################################
vim.api.nvim_create_augroup('setFileType', { clear = true })
-- yml as ansible, instead of yaml
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = 'setFileType',
  pattern = {"*.yml"},
  callback = function()
    vim.o.filetype = 'ansible'
  end
})

-- md as markdown, instead of modula2
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = 'setFileType',
  pattern = {"*.md", "*.mdwn", "*.mkd", "*.mkdn", ".mark*"},
  callback = function()
    vim.o.filetype = 'markdown'
  end
})

-- bb as bitbake
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  group = 'setFileType',
  pattern = {"*.bb", "*.bbappend", "*.bbclass"},
  callback = function()
    vim.o.filetype = 'bitbake'
  end
})

--###############################################################
-- Search document by cword
--###############################################################
vim.api.nvim_create_augroup("overrideKeywordprg", {clear = true})
-- override keywordprg to man command
vim.api.nvim_create_autocmd({'FileType'}, {
  group = 'overrideKeywordprg',
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
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.wo.listchars = ''
    vim.wo.number = false
    vim.wo.cursorline = false
    vim.wo.relativenumber = false
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

--###############################################################
-- LSP
--###############################################################
-- LspSaga
vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "UserLspConfig",
  pattern = "LspsagaHover",
  callback = function()
    vim.keymap.set("n", "<ESC>", "<cmd>close!<cr>", {buffer=true, silent=true, nowait=true})
  end
})

--###############################################################
-- IME
--###############################################################
local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end

if not G.is_headless then
  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
      group = ime_input,
      pattern = "*",
      callback = set_ime
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
      group = ime_input,
      pattern = "[/\\?]",
      callback = set_ime
  })
end
---- disale IME on InsertEnter and restore IME status on Leave
--if not vim.env.WT_SESSION then
--  vim.api.nvim_create_augroup("RestoreIME", { clear = true })
--  vim.api.nvim_create_autocmd("InsertEnter", {
--    group = "RestoreIME",
--    pattern = "*",
--    callback = function ()
--      if vim.env.TMUX then
--        vim.fn.chansend(vim.v.stderr, [[\ePtmux;\e\e[<r\e\\]])
--      else
--        vim.fn.chansend(vim.v.stderr, [[\e[<r]])
--      end
--    end
--  })
--  vim.api.nvim_create_autocmd("InsertLeave", {
--    group = "RestoreIME",
--    pattern = "*",
--    callback = function ()
--      if vim.env.TMUX then
--        vim.fn.chansend(vim.v.stderr, [[\ePtmux;\e\e[<s\e\e[<0t\e\\]])
--      else
--        vim.fn.chansend(vim.v.stderr, [[\e[<s\e[<0t]])
--      end
--    end
--  })
--  vim.api.nvim_create_autocmd("VimLeave", {
--    group = "RestoreIME",
--    pattern = "*",
--    callback = function ()
--      if vim.env.TMUX then
--        vim.fn.chansend(vim.v.stderr, [[\ePtmux;\e\e[<0t\e\e[<s\e\\]])
--      else
--        vim.fn.chansend(vim.v.stderr, [[\e[<0t\e[<s]])
--      end
--    end
--  })
--end
