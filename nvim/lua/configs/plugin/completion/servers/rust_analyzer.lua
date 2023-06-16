return function(opts)
  local rust_tools_opts = { server = {} }
  rust_tools_opts.server.autostart = true
  rust_tools_opts.server.on_attach = opts.on_attach
  rust_tools_opts.server.capabilities = opts.capabilities
  require("rust-tools").setup(rust_tools_opts)
end
