local utils = require("envutils")
local G = utils:globals()
local dict_dir = utils:path_concat({G.homedir,  ".config", "skk", "dict", ""})
return function ()
  local maps = require("configs.keymap").skkeleton
  require("denops-lazy").load("skkeleton", { wait_load = false })
  for _, v in pairs(maps) do
    vim.keymap.set(v.mode, v[1], v[2], { remap = true, desc = v.desc })
  end

  local mkdir_p = function(path, mode)
    local success, err = vim.uv.fs_mkdir(path, mode)
    if success then
      return true
    elseif err and string.match(err, "^EEXIST") then
      return true
    elseif err and string.match(err, "^ENOENT") then
      success, err = vim.uv.fs_mkdir(utils:path_concat({path, ".."}), mode)
      if not success then return nil, err end
      return vim.uv.fs_mkdir(path, mode)
    end

    return nil, err
  end

  local userDictionary = nil
  local userDictionaryDir = utils:path_concat({G.nvim_data_dir, "skk", ""})
  local S_IRWXU = 0x1C0 -- 0700 (octal)
  local S_IRGRP = 0x020 -- 0040 (octal)
  local S_IXGRP = 0x008 -- 0010 (octal)
  local S_IROTH = 0x004 -- 0004 (octal)
  local S_IXOTH = 0x001 -- 0001 (octal)
  local mode = S_IRWXU + S_IRGRP + S_IXGRP + S_IROTH + S_IXOTH -- 0755 (octal)
  local success, err = mkdir_p(userDictionaryDir, mode)
  if success then
    userDictionary = utils:path_concat({userDictionaryDir, "neovim-skk-userdict.txt"})
  elseif err then
    utils.pr_error("failed to create directory for skk user-dict", {title = "skkeleton"})
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
    usePopup = false,
    userDictionary = userDictionary
  })
end
