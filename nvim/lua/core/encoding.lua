-- this setting taken from http://web.archive.org/web/20160306071624/http://www.kawaz.jp/pukiwiki/?vim#cb691f26
-- and convert lua script by orumin

-- start detect encodings for Japanese

if vim.o.encoding ~= "utf-8" then
  vim.o.encoding = "japan"
  vim.o.fileencoding = "japan"
end

if vim.fn.has("iconv") == 1 then
  local iconv = vim.fn.iconv

  local enc_euc = 'euc-jp'
  local enc_jis = 'iso-2022-jp'

  -- check iconv support 'eucJP-ms'
  if iconv("\x87\x64\x87\x6a", "cp932", "eucjp-ms") == "\xad\xc5\xad\xcb" then
    enc_euc = 'eucjp-ms'
    enc_jis = 'iso-2022-jp-3'
  -- check iconv support 'JISX0213'
  elseif iconv("\x87\x64\x87\x6a", "cp932", "euc-jisx0213") == "\xad\xc5\xad\xcb" then
    enc_euc = 'euc-jisx0213'
    enc_jis = 'iso-2022-jp-3'
  end

  -- construct fileencodings
  if vim.o.encoding == "utf-8" then
    vim.opt.fileencodings:prepend({enc_jis, enc_euc , "cp932"})
  else
    vim.opt.fileencodings:append({enc_jis, "utf-8", "ucs-2le", "ucs-2"})
    if not vim.regex("^\\(euc-jp\\|euc-jisx0213\\|eucjp-ms\\)$"):match(vim.o.encoding) then
      vim.opt.fileencodings.append({"cp932"})
      vim.opt.fileencodings.remove({"euc-jp", "euc-jisx0213", "eucjp-ms"})
      vim.o.encoding = enc_euc
      vim.o.fileencoding = enc_euc
    else
      vim.opt.fileencodings:append({enc_euc})
    end
  end
end

-- set fileencoding to same as encoding if detected language is not contained "Japanese"
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "",
  callback = function()
    if vim.o.fileencoding ~= "iso-2022-jp" and
      vim.fn.search("[^\x01-\x7e]", "n") == 0 then

      vim.o.fileencoding = vim.o.encoding
    end
  end
})

-- detect newline chracter
vim.opt.fileformats={"unix", "dos", "mac"}

-- set ambiwidth size (single or double)
vim.opt.ambiwidth="single"
