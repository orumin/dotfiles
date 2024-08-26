local opts = {
  symbols = {
    merge_commit = '●',
    commit = '∙',
  },
  format = {
    timestamp = '%Y-%m-%dT%H:%M:%S',
    fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
  },
  hooks = {
    on_select_commit = function (commit)
      vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
      vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
    end,
    on_select_range_commit = function (from, to)
      vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
      vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
    end,
  },
}

return opts
