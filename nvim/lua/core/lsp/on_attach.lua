return {
  setup = function ()
    local clangd_conf = require("configs.plugin.lsp.servers.clangd_conf")
    local clangd_settings = clangd_conf.lsp_opts
    local cpp_augroup = vim.api.nvim_create_augroup("CppLspAttach", {clear = true})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = cpp_augroup,
      pattern = clangd_settings.filetypes,
      callback = function (auopts)
        local root_dir = clangd_settings.root_dir(auopts.file)
        local ok, cmake_session = pcall(require, "cmake-tools.session")
        if ok then
          cmake_session.save({
            build_directory = "build",
            build_type = "Debug",
            cwd = root_dir
          })
        end
      end
    })
  end
}
