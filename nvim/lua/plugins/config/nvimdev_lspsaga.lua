local ok, lspsaga_kind
ok, lspsaga_kind = pcall(require, "lspsaga.lspkind")
if not ok then
  vim.notify("error loading lspsaga")
  return
end

local ui_kind = {}
local lspkind_conf
ok, lspkind_conf = pcall(require, "plugins.config.lspkind")
if ok then
  ui_kind = lspkind_conf.symbol_map
end

require("lspsaga").setup({
  border_style = "single",
  ui = {
    title = true,
    border = "single",
    code_action = "",
    kind = lspsaga_kind.get_kind(ui_kind)
  },
})
--[[
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  code_action_icon = " ",
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  definition_preview_icon = "  ",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
]]--
