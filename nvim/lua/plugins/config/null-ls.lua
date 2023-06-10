local ok, null_ls = pcall(require, "null-ls")
if not ok then
  pr_error("error loading null-ls")
  return
end

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.diagnostics.actionlint,
--        null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.code_actions.cspell,
        null_ls.builtins.code_actions.shellcheck,
    },
})
