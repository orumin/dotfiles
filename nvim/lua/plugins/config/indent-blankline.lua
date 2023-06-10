local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
  pr_error("error loading indent_blankline")
  return
end

indent_blankline.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
