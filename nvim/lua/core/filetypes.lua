local configs = require("configs")
if vim.filetype then
  vim.filetype.add(configs.filetypes)
else
  vim.api.nvim_create_augroup('setFileType', { clear = false })
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

  -- dis as disassembly
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = 'setFileType',
    pattern = {"*.dis"},
    callback = function()
      vim.o.filetype = 'disassembly'
    end
  })
end
