return {
  {"<leader>ps", function() require("piccolo-pomodoro").start() end, mode = "n", desc = "start pomodoro timer"},
  {"<leader>pp", function() require("piccolo-pomodoro").pause() end, mode = "n", desc = "pause pomodoro timer"},
  {"<leader>pt", function() require("piccolo-pomodoro").toggle() end, mode = "n", desc = "toggle pomodoro timer"},
  {"<leader>ph", function() require("piccolo-pomodoro").print_status() end, mode = "n", desc = "show pomodoro timer status"},
  {"<leader>pk", function() require("piccolo-pomodoro").skip() end, mode = "n", desc = "skip pomodoro timer"},
  {"<leader>pr", function() require("piccolo-pomodoro").reset() end, mode = "n", desc = "reset pomodoro timer"},
}
