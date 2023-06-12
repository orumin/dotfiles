return {
  output = {
    float = {
      max_width = 40,
      max_height = 5,
      close_on_cursor_move = true,
      enter_key = "T",
    }
  },
  translate = {
    {
      cmd = "TransToEn",
      command = "trans",
      args = function(trans_source)
        return {
          "-b",
          "-e",
          "google",
          "-t",
          "en",
          trans_source
        }
      end,
      -- how to get translate source
      -- selection | input | clipboard
      input = "selection",
      -- how to output translate result
      -- float_win | notify | clipboard | insert
      output = { "notify", "clipboard" }
    },
  },
}
