local settings = require("configs.global_settings")

if settings.remove_trailing_space then
  -- remove trailing spaces on save
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

-- LspSaga
vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "UserLspConfig",
  pattern = "LspsagaHover",
  callback = function()
    vim.keymap.set("n", "<ESC>", "<cmd>close!<cr>", {buffer=true, silent=true, nowait=true})
  end
})

-- disale IME on InsertEnter and restore IME status on Leave
if not vim.env.WT_SESSION then
  vim.api.nvim_create_augroup("RestoreIME", { clear = true })
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = "RestoreIME",
    pattern = "*",
    callback = function ()
      if vim.env.TMUX then
        vim.fn.chansend(vim.v.stderr, [[\ePtmux;\e\e[<r\e\\]])
      else
        vim.fn.chansend(vim.v.stderr, [[\e[<r]])
      end
    end
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    group = "RestoreIME",
    pattern = "*",
    callback = function ()
      if vim.env.TMUX then
        vim.fn.chansend(vim.v.stderr, [[\ePtmux;\e\e[<s\e\e[<0t\e\\]])
      else
        vim.fn.chansend(vim.v.stderr, [[\e[<s\e[<0t]])
      end
    end
  })
  vim.api.nvim_create_autocmd("VimLeave", {
    group = "RestoreIME",
    pattern = "*",
    callback = function ()
      if vim.env.TMUX then
        vim.fn.chansend(vim.v.stderr, [[\ePtmux;\e\e[<0t\e\e[<s\e\\]])
      else
        vim.fn.chansend(vim.v.stderr, [[\e[<0t\e[<s]])
      end
    end
  })
end
