return {
  {"<F1>", function()
    local prof = require("profile")
    if prof and prof.is_recording() then
      prof.stop()
      vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
        if filename then
          prof.export(filename)
          --vim.notify(string.format("Wrote %s", filename))
        end
      end)
    else
      prof.start("*")
    end
  end, desc = "start/stop profiler"}
}
