local utils = require("envutils")
local G = utils:globals()
local dict_dir = utils:path_concat({G.homedir,  ".config", "skk", "dict", ""})
return function ()
  if not (vim.fn.has("nvim-0.8") == 1 and require("configs").use_skk) then
    -- if configured 'disabled', nothing to do
    return
  end
  local maps = require("configs.keymap").skkeleton
  require("denops-lazy").load("skkeleton", { wait_load = false })
  for _, v in pairs(maps) do
    vim.keymap.set(v.mode, v[1], v[2], { remap = true, desc = v.desc })
  end

  local userDictionary = nil
  local userDictionaryDir = utils:path_concat({G.nvim_data_dir, "skk", ""})
  local mode = utils.S_IRWXU + utils.S_IRGRP + utils.S_IXGRP + utils.S_IROTH + utils.S_IXOTH -- 0755 (octal)
  local success, _, msg = utils:mkdir_p(userDictionaryDir, mode)
  if success then
    userDictionary = utils:path_concat({userDictionaryDir, "neovim-skk-userdict.txt"})
  else
    utils.pr_error("failed to create directory for skk user-dict ("..tostring(msg)..")", {title = "skkeleton"})
  end

  vim.fn["skkeleton#config"]({
    eggLikeNewline = true,
    globalDictionaries = {
      -- lisp macro
      { dict_dir .. "SKK-JISYO.lisp", "euc-jp"},
      -- global dict
      { dict_dir .. "SKK-JISYO.L", "euc-jp"},
--      -- kana-kanjii
      { dict_dir .. "SKK-JISYO.mazegaki", "euc-jp"},
      { dict_dir .. "SKK-JISYO.hukugougo", "euc-jp"},
--      -- kanji (use low frequency)
      { dict_dir .. "SKK-JISYO.JIS2", "euc-jp"},
      { dict_dir .. "SKK-JISYO.itaiji", "euc-jp"},
      dict_dir .. "SKK-JISYO.ivd",
--      -- emoji
      dict_dir .. "SKK-JISYO.emoji",
--      -- names
      { dict_dir .. "SKK-JISYO.fullname", "euc-jp"},
      { dict_dir .. "SKK-JISYO.jinmei", "euc-jp"},
--      -- law term
      { dict_dir .. "SKK-JISYO.law", "euc-jp"},
--      -- others
      { dict_dir .. "SKK-JISYO.geo", "euc-jp"},
      { dict_dir .. "SKK-JISYO.station", "euc-jp"},
      { dict_dir .. "SKK-JISYO.okinawa", "euc-jp"},
      { dict_dir .. "SKK-JISYO.assoc", "euc-jp"},
      { dict_dir .. "SKK-JISYO.edict", "euc-jp"},
      { dict_dir .. "SKK-JISYO.propernoun", "euc-jp"},
      dict_dir .. "SKK-JISYO.edict2",
      { dict_dir .. "SKK-JISYO.china_taiwan", "euc-jp"},
      dict_dir .. "SKK-JISYO.pinyin",
    },
    userDictionary = userDictionary
  })
end
