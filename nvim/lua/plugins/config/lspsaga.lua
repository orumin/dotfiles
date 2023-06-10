local kind = {
  ["File"] = { " ", "Tag" },
  ["Module"] = { " ", "Exception" },
  ["Namespace"] = { "ﴯ ", "Include" },
  ["Package"] = { " ", "Label" },
  ["Class"] = { "ﴯ ", "Include" },
  ["Method"] = { " ", "Function" },
  ["Property"] = { "ﰠ ", "@property" },
  ["Field"] = { "ﰠ ", "@field" },
  ["Constructor"] = { " ", "@constructor" },
  ["Enum"] = { " ", "@number" },
  ["Interface"] = { " ", "Type" },
  ["Function"] = { " ", "Function" },
  ["Variable"] = { " ", "@variable" },
  ["Constant"] = { " ", "Constant" },
  ["String"] = { " ", "String" },
  ["Number"] = { "󰎠 ", "Number"  },
  ["Boolean"] = { " ", "Boolean" },
  ["Array"] = { " ", "Type" },
  ["Object"] = { " ", "Type" },
  ["Key"] = { " ", "Constant" },
  ["Null"] = { " ", "Constant" },
  ["EnumMember"] = { " ", "Number" },
  ["Struct"] = { "פּ ", "Type" },
  ["Event"] = { " ", "Constant" },
  ["Operator"] = { " ", "Operator" },
  ["TypeParameter"] = { "", "Type" },
  -- ccls
  ["TypeAlias"] = { " ", "Type" },
  ["Parameter"] = { " ", "@parameter" },
  ["StaticMethod"] = { " ", "Function" },
  ["Macro"] = { " ", "Macro" },
  -- for completion sb microsoft!!!
  ["Text"] = { " ", "String" },
  ["Snippet"] = { " ", "@variable" },
  ["Folder"] = { " ", "Title" },
  ["Unit"] = { "塞 ", "Number" },
  ["Value"] = { " ", "@variable" },
}

local ok, lspsaga = pcall(require, "lspsaga")
if not ok then
  pr_error("error loading lspsaga")
  return
end

lspsaga.setup({
  ui = {
    kind = kind
  }
})
