return {
  ["dap"] = {
    { "<F5>", function () require("dap").continue() end, mode = "n", desc = "DAP Continue" },
    { "<F9>", function () require("dap").toggle_breakpoint() end, mode = "n", desc = "DAP Toggle Breakpoint" },
    { "<F10>", function () require("dap").step_over() end, mode = "n", desc = "DAP Step Over" },
    { "<F11>", function () require("dap").step_into() end, mode = "n", desc = "DAP Step Into" },
  },
  ["dap-view"] = {
    { "<F7>", function () vim.cmd("DapViewToggle") end, mode = "n", desc = "DAP Toggle REPL" },
  }
}
