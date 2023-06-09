-- remove trailing spaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

vim.api.nvim_create_augroup('setTextwidth', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'setTextwidth',
  pattern = { 'text' },
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
  pattern = {"*.bb"},
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
