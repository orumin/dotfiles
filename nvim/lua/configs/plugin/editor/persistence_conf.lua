local envutils = require("envutils")
local G = envutils:globals()
return {
  dir = G.nvim_state_dir .. "/sessions/",
  need = 1,
  branch = true,
}
