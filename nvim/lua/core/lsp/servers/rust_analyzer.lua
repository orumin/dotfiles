return function(opts)
  local rt = require("rust-tools")
  local rt_executor = require("rust-tools.executors").termopen
  local rust_tools_opts = {
    tools = {
      executor = rt_executor,
      on_initialized = nil,
      reload_workspace_from_cargo_toml = true,
      inlay_hints = { auto = false }
    },
    server = {}
  }
  rust_tools_opts.server.autostart = true
  rust_tools_opts.server.capabilities = opts.capabilities
  rust_tools_opts.server.on_attach = function (_, bufnr)
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "rust hover actions"  })
    vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "rust code action group" })
  end

  rt.setup(rust_tools_opts)
end
