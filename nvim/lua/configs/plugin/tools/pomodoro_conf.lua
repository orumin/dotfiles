return function()
  require("piccolo-pomodoro").setup({
    focus_time = 25, -- minutes
    break_time = 5, -- minutes
    long_break_time = 15, -- minutes
    long_break_interval = 4,
    auto_start_breaks = false,
    auto_start_pomodoros = false,

    on_start = function() end,

    on_update = function() end,

    on_pause = function() end,

    on_complete_focus_time = function()
      vim.notify("Complete focus time", vim.log.levels.INFO, {title="pomodoro"})
    end,

    on_complete_break_time = function()
      vim.notify("Break time completed", vim.log.levels.INFO, {title="pomodoro"})
    end,

    focus_format = function(ctx)
      return string.format("󰔟 focus %02d:%02d", ctx.m, ctx.s)
    end,

    break_format = function(ctx)
      return string.format("󰛊 break %02d:%02d", ctx.m, ctx.s)
    end,
  })
end
