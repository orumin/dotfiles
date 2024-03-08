return function ()
  require("CopilotChat").setup({
    show_help = "yes",
    debug = false,
    disable_extra_info = false,
    language = "English",
    -- proxy = "socks5://127.0.0.1:3000",  Proxies requirests via https or scoks.
    -- temperature = 0.1,
  })
end
