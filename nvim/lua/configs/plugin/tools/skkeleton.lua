local utils = require("utils")
local G = utils.globals()
local dict_dir= G.homedir .. G.path_sep .. ".config" .. G.path_sep .. "skk" .. G.path_sep .. "dict" .. G.path_sep
return function ()
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
    }
  })
end
