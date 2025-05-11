local M = {}

local icons = {
  diagnostics = require("configs.ui.icons").get("diagnostics"),
  codicons = require("configs.ui.icons").get("codicons"),
}

---@type vim.lsp.Config
M.lsp_opts = {
  filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
  capabilities = { offsetEncoding = { "utf-16", "utf-8" } },
  single_file_support = true,
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  root_dir = require("lspconfig.util")
               .root_pattern("build/compile_commands.json", ".git", "compile_commands.json", "compile_flags.txt"),
  on_attach = function (_, bufnr)
    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.hover({border=require("configs").window_style.border}) end, { buffer = bufnr })
    vim.keymap.set("n", "K", function()
      vim.cmd(vim.o.keywordprg .. " " .. vim.fn.expand("<cword>"))
    end, { buffer = bufnr, desc = "search document by cword" })

    local ok, cmake_session = pcall(require, "cmake-tools.session")
    if ok then
      cmake_session.save({
        build_directory = "build",
        build_type = "Debug",
      })
    end
  end,
}

M.ext_opts = {
  inlay_hints = {
    inline = false,
    -- Options other than `highlight' and `priority' only work
    -- if `inline' is disabled
    -- Only show inlay hints for the current line
    only_current_line = false,
    -- Event which triggers a refersh of the inlay hints.
    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
    -- not that this may cause  higher CPU usage.
    -- This option is only respected when only_current_line and
    -- autoSetHints both are true.
    only_current_line_autocmd = "CursorHold",
    -- whether to show parameter hints with the inlay hints or not
    show_parameter_hints = true,
    -- prefix for parameter hints
    parameter_hints_prefix = "<- ",
    -- prefix for all the other hints (type, chaining)
    other_hints_prefix = "=> ",
    -- whether to align to the length of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- whether to align to the extreme right or not
    right_align = false,
    -- padding from the right if right_align is true
    right_align_padding = 7,
    -- The color of the hints
    highlight = "Comment",
    -- The highlight group priority for extmark
    priority = 100,
  },
  ast = {
    --[[ These are unicode, should be available in any font
          role_icons = {
               type = "🄣",
               declaration = "🄓",
               expression = "🄔",
               statement = ";",
               specifier = "🄢",
               ["template argument"] = "🆃",
          },
          kind_icons = {
              Compound = "🄲",
              Recovery = "🅁",
              TranslationUnit = "🅄",
              PackExpansion = "🄿",
              TemplateTypeParm = "🅃",
              TemplateTemplateParm = "🅃",
              TemplateParamObject = "🅃",
          },]]
    -- These require codicons (https://github.com/microsoft/vscode-codicons)
    role_icons = {
      type = icons.codicons.Type,
      declaration = icons.codicons.Declaration,
      expression = icons.codicons.Expression,
      specifier = icons.codicons.Specifier,
      statement = icons.codicons.Statement,
      ["template argument"] = icons.codicons.TemplateParam,
    },

    kind_icons = {
      Compound = icons.codicons.Compound,
      Recovery = icons.diagnostics.Error_alt,
      TranslationUnit = icons.codicons.TranslationUnit,
      PackExpansion = icons.codicons.PackExpansion,
      TemplateTypeParm = icons.codicons.TemplateParam,
      TemplateTemplateParm = icons.codicons.TemplateParam,
      TemplateParamObject = icons.codicons.TemplateParam,
    },

    highlights = {
      detail = "Comment",
    },
  },
  memory_usage = {
    border = "none",
  },
  symbol_info = {
    border = "none",
  },
}

return M
