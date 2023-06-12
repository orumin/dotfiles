function  _G.pr_error(msg, opts)
  vim.notify(msg, vim.log.levels.ERROR, opts)
end

function _G.nnoremap (lhs, rhs)
  vim.keymap.set("n", lhs, rhs, {noremap = true, silent = true})
end

