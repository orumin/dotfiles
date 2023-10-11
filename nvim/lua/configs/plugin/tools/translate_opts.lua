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
      cmd = "TransToEN",
      command = "trans",
      args = function(trans_source)
        return {
          "-b",
          "-e",
          "google",
          "-t",
          "en-US",
          trans_source
        }
      end,
      -- how to get translate source
      -- selection | input | clipboard
      input = "selection",
      -- how to output translate result
      -- float_win | notify | clipboard | insert
      output = { "float_win" }
    },
  },
}
