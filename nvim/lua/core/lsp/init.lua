---@class myLspConf
local M = {}

---@param bufnr integer
---@param maps table[]
local function set_keymaps(bufnr, maps)
  local utils = require("envutils")
  for _, v in pairs(maps) do
    local opts = utils.get_keymap_opts(v)
    local lhs = v.lhs or v[1]
    local rhs = v.rhs or v[2]
    local mode = v.mode or "n"
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

---@param client vim.lsp.Client
---@param bufnr integer
local function on_lsp_attach(client, bufnr)
  local keymaps = require("configs.keymap.nvim-lsp")
  local methods = vim.lsp.protocol.Methods

  vim.wo.signcolumn = 'yes'
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"

  ---@param method_prefix string
  ---@param keymap_table table
  local function set_keymaps_for_supported_methods(method_prefix, keymap_table)
    for k, v in pairs(keymap_table) do
      if client.supports_method(methods[method_prefix .. k]) then
        set_keymaps(bufnr, v)
      end
    end
  end
  set_keymaps_for_supported_methods("textDocument_", keymaps["textDocument"])
  set_keymaps_for_supported_methods("callHierarchy_", keymaps["callHierarchy"])
  set_keymaps_for_supported_methods("workspace_", keymaps["workspace"])

  -- show signatureHelp by nvim-cmp. so didn't create keymaps to call vim.lsp.buf.signature_help
  --if client.supports_method(methods["textDocument_signatureHelp"]) then
  --  local signature_help_group = vim.api.nvim_create_augroup("LSP_signatureHelp", { clear = false })
  --  vim.api.nvim_create_autocmd("CursorHoldI", {
  --    group = signature_help_group,
  --    desc = "Show signatureHelp in insert mode",
  --    buffer = bufnr,
  --    callback = vim.lsp.buf.signature_help
  --  })
  --end

  if client.supports_method(methods["textDocument_documentHighlight"]) then
    local under_cursor_highlights_group =
      vim.api.nvim_create_augroup('LSP_documentHighlights', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave', 'BufEnter' }, {
      group = under_cursor_highlights_group,
      desc = 'Highlight references under the cursor',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
      group = under_cursor_highlights_group,
      desc = 'Clear highlight references',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.supports_method(methods["textDocument_codeLens"]) then
    local codelens_group = vim.api.nvim_create_augroup('LSP_codeLens', { clear = false })
    vim.api.nvim_create_autocmd('InsertEnter', {
      group = codelens_group,
      desc = 'Disable CodeLens in insert mode',
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.clear(client.id, bufnr)
      end,
    })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      group = codelens_group,
      desc = 'Refresh CodeLens',
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh({ bufnr = bufnr })
      end,
    })

    -- Initial CodeLens display.
    vim.lsp.codelens.refresh({ bufnr = bufnr })
  end

  if client.supports_method(methods["textDocument_inlayHint"]) then
    local ltype = type(vim.lsp.inlay_hint)
    local toggle_inlay_hint = (ltype == "function") and vim.lsp.inlay_hint
                              or (ltype == "table" and vim.lsp.inlay_hint.enable)
                              or function () end
    local inlay_hints_group = vim.api.nvim_create_augroup('LSP_inlayHints', { clear = false })

    -- Initial inlay hint display.
    -- Idk why but without the delay inlay hints aren't displayed at the very start.
    vim.defer_fn(function()
      local mode = vim.api.nvim_get_mode().mode
      local enabled = mode == "n" or mode == "v"
      toggle_inlay_hint(enabled, {bufnr = bufnr})
    end, 500)

    vim.api.nvim_create_autocmd('InsertEnter', {
      group = inlay_hints_group,
      desc = 'Enable inlay hints',
      buffer = bufnr,
      callback = function()
        toggle_inlay_hint(false, {bufnr = bufnr})
      end,
    })
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = inlay_hints_group,
      desc = 'Disable inlay hints',
      buffer = bufnr,
      callback = function()
        toggle_inlay_hint(true, {bufnr = bufnr})
      end,
    })

    require("configs.ui.color").set_lsp_hl()

  end
end

local md_namespace = vim.api.nvim_create_namespace("LSP_float")
---@param bufnr integer
---@param winnr integer
---@return any?
local function enhanced_float_win(bufnr, winnr)
  -- Conceal everything.
  vim.wo[winnr].concealcursor = 'n'

  -- Extra highlights.
  for l, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    for pattern, hl_group in pairs {
      ['|%S-|'] = '@text.reference',
      ['@%S+'] = '@parameter',
      ['^%s*(Parameters:)'] = '@text.title',
      ['^%s*(Return:)'] = '@text.title',
      ['^%s*(See also:)'] = '@text.title',
      ['{%S-}'] = '@parameter',
    } do
      local from = 1 ---@type integer?
      while from do
        local to
        from, to = line:find(pattern, from)
        if from then
          vim.api.nvim_buf_set_extmark(bufnr, md_namespace, l - 1, from - 1, {
            end_col = to,
            hl_group = hl_group,
          })
        end
        from = to and to + 1 or nil
      end
    end
  end

  -- Add keymaps for opening links.
  if not vim.b[bufnr].markdown_keys then
    vim.keymap.set('n', 'K', function()
      -- Vim help links.
      local url = (vim.fn.expand '<cWORD>' --[[@as string]]):match '|(%S-)|'
      if url then
        return vim.cmd.help(url)
      end

      -- Markdown links.
      local col = vim.api.nvim_win_get_cursor(0)[2] + 1
      local from, to
      from, to, url = vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
      if from and col >= from and col <= to then
        vim.system({ 'open', url }, nil, function(res)
          if res.code ~= 0 then
            vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
          end
        end)
      end
    end, { buffer = bufnr, silent = true })
    vim.b[bufnr].markdown_keys = true
  end
end

---LSP handler that adds extra inline highlights, keymaps, and window options.
---Code inspired from `noice`.
---@param handler fun(err: lsp.ResponseError|nil, result: table?, context: lsp.HandlerContext, config: table|nil): any?
---@return function
local function enhanced_float_handler(handler)
  return function(err, result, ctx, config)
    local configs = require("configs")
    local bufnr, winnr = handler(
      err,
      result,
      ctx,
      vim.tbl_deep_extend('force', config or {}, {
        border = configs.window_style.border,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
        winblend = configs.window_style.winblend
      })
    )

    if not bufnr or not winnr then
      return
    end

    enhanced_float_win(bufnr, winnr)
  end
end

---@return lsp.ClientCapabilities
local function make_capabilities()
  local utils = require("envutils")
  local G = utils:globals()
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if not ok then
    G.pr_error("error loading cmp_nvim_lsp")
    cmp_nvim_lsp = nil
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if cmp_nvim_lsp ~= nil then
    capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      cmp_nvim_lsp.default_capabilities(capabilities),
      {
        workspace = {
          -- PERF: didChangeWatchedFiles is too slow
          -- TODO: remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed
          didChangeWatchedFiles = { dynamicRegistration = false },
        },
        textDocument = {
          -- Enable folding.
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }
        }
      }
    ) or {}
  end

	return capabilities
end

M.windows = {}

---@param err lsp.ResponseError|nil
---@param result lsp.Location|lsp.LocationLink
---@param context lsp.HandlerContext
---@param config table|nil
---@return any?
---@diagnostic disable-next-line: unused-local
local function preview_location_cb(err, result, context, config)
  if not result or vim.tbl_isempty(result) then
    local log = require("vim.lsp.log")
    log.info(context, "No location found.")
    vim.lsp.buf.hover()
    return nil
  end
  local current_bufnr = vim.api.nvim_get_current_buf()

  local id = "location"
  local target_win = vim.iter(vim.api.nvim_list_wins()):find(function(v)
    return vim.F.npcall(vim.api.nvim_win_get_var, v, id) == current_bufnr
  end)
  if target_win and vim.api.nvim_win_is_valid(target_win) and vim.fn.pumvisible() == 0 then
    vim.api.nvim_set_current_win(target_win)
    vim.cmd("stopinsert")
    return
  end

  local existing_win = vim.F.npcall(vim.api.nvim_buf_get_var, current_bufnr, "lsp_peek")
  if existing_win and vim.api.nvim_win_is_valid(existing_win) then vim.api.nvim_win_close(existing_win, true) end

---@diagnostic disable-next-line: deprecated
  local islist = vim.tbl_islist or vim.islist
  local location = islist(result) and result[1] or result
  local uri = location.targetUri or location.uri
  local range = location.targetRange or location.range
  local preview_bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(preview_bufnr) then
    vim.fn.bufload(preview_bufnr)
  end

  local configs = require("configs")
  local current_cursor = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
  local preview_winnr = vim.api.nvim_open_win(preview_bufnr, false, {
    relative = "win",
    bufpos = current_cursor,
    height = 20,
    width = 120,
    zindex = #M.windows + 1,
    style = "minimal",
    border = configs.window_style.border,
    title = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(preview_bufnr), ":."),
  })
  table.insert(M.windows, preview_winnr)
  vim.api.nvim_win_set_cursor(preview_winnr, {range.start.line+1, range.start.character})

  vim.wo[preview_winnr].conceallevel = 2
  vim.wo[preview_winnr].foldenable = false
  if current_bufnr ~= preview_bufnr then
    vim.bo[preview_bufnr].modifiable = false
    vim.bo[preview_bufnr].bufhidden = "wipe"
  end
  vim.api.nvim_win_set_var(preview_winnr, id, current_bufnr)
  vim.api.nvim_buf_set_var(current_bufnr, "lsp_peek", preview_winnr)

  if current_bufnr == preview_bufnr then
    vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(preview_winnr, true)
      vim.keymap.del("n", "q", {buffer = preview_bufnr})
    end, {buffer = preview_bufnr, silent = true, noremap = true, nowait = true})
  else
    vim.keymap.set("n", "q", "<Cmd>bdelete<CR>", {buffer = preview_bufnr, silent = true, noremap = true, nowait = true})
  end

  local close_window = function(winnr, bufnrs)
    vim.schedule(function ()
      if bufnrs and vim.list_contains(bufnrs, vim.api.nvim_get_current_buf()) then
        return
      end

      if vim.api.nvim_win_get_config(vim.api.nvim_get_current_win()).relative ~= "" then
        return
      end

      local augroup = "preview_window_" .. winnr
      pcall(vim.api.nvim_del_augroup_by_name, augroup)
      pcall(vim.api.nvim_win_close, winnr, true)
      for i, v in ipairs(M.windows) do
        if v == winnr then
          table.remove(M.windows, i)
          return
        end
      end
    end)
  end

  local augroup = vim.api.nvim_create_augroup("peek_window_" .. preview_winnr, {clear = true})
  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = function ()
      close_window(preview_winnr, {preview_bufnr, current_bufnr})
    end
  })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertCharPre" }, {
    group = augroup,
    buffer = current_bufnr,
    callback = function ()
      close_window(preview_winnr)
    end
  })
end

---@return table<integer, integer> client_request_ids Map of client-id:request-id pairs
---for all successful requests.
---@return function _cancel_all_requests Function which can be used to
---cancel all the requests. You could instead
---iterate all clients and call their `cancel_request()` methods.
M.peek_definition = function()
  local methods = vim.lsp.protocol.Methods
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, methods.textDocument_definition, params, preview_location_cb)
end

---@return table<integer, integer> client_request_ids Map of client-id:request-id pairs
---for all successful requests.
---@return function _cancel_all_requests Function which can be used to
---cancel all the requests. You could instead
---iterate all clients and call their `cancel_request()` methods.
M.peek_type_definition = function()
  local methods = vim.lsp.protocol.Methods
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, methods.textDocument_typeDefinition, params, preview_location_cb)
end

---@return table<integer, integer> client_request_ids Map of client-id:request-id pairs
---for all successful requests.
---@return function _cancel_all_requests Function which can be used to
---cancel all the requests. You could instead
---iterate all clients and call their `cancel_request()` methods.
M.peek_implementation = function()
  local methods = vim.lsp.protocol.Methods
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, methods.textDocument_implementation, params, preview_location_cb)
end

M.setup_handlers = function()
  local opts = {
    autostart = true,
    capabilities = make_capabilities(),
  }

  local methods = vim.lsp.protocol.Methods
  -- LSP handlers
  vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover)
  vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help)

  ---@param server_name string
  local function mason_handler(server_name)
    local configs = require("configs")
    local utils = require("envutils")
    local G = utils:globals()
    require("lspconfig.ui.windows").default_options.border = configs.window_style.border
    local lspconfig = require("lspconfig")

    if vim.iter(configs.lsp_disabled_servers):find(server_name) ~= nil then
      G.pr_info("skip setup language_server, " .. server_name, {title = "nvim-lspconfig"})
      return
    end

    local ok, custom_handler = pcall(require, "core.lsp.servers." .. server_name)
    if not ok then
      lspconfig[server_name].setup(opts)
    elseif type(custom_handler) == "function" then
      custom_handler(opts)
    elseif type(custom_handler) == "table" then
      lspconfig[server_name].setup(vim.tbl_deep_extend("force", opts, custom_handler))
    else
      G.pr_error("Failed to setup [" .. server_name .. "]. fix core/lsp/servers/" .. server_name .. ".lua",
        {title = "nvim-lspconfig"})
    end
  end

  local configs = require("configs")
  local servers = configs.lsp_default_servers
  local mason_lspconfig = require("mason-lspconfig")
  mason_lspconfig.setup({
    ensure_installed = servers,
  })
  mason_lspconfig.setup_handlers({ mason_handler })
end

M.setup = function()
  local configs = require("configs")
  local diagnostic_icons = require("configs.ui.icons").get("diagnostics")
  local signs = {
    ERROR = diagnostic_icons.Error,
    WARN = diagnostic_icons.Warning,
    INFO = diagnostic_icons.Information,
    HINT = diagnostic_icons.Hint_alt,
  }

  -- Define the diagnostic signs
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type:sub(1,1) .. type:sub(2):lower()
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Diagnostic configuration
  vim.diagnostic.config({
    virtual_lines = {
      only_current_line = true
    },
    virtual_text = false,
--    virtual_text = {
--      prefix = function (diagnostic)
--        return signs[vim.diagnostic.severity[diagnostic.severity]] .. ' '
--      end,
--      format = function (diagnostic)
--        return vim.split(diagnostic.message, '\n')[1]
--      end
--    },
    float = {
      border = configs.window_style.border,
      winblend = configs.window_style.winblend,
      source = "if_many",
      prefix = function (diagnostic)
        local level = vim.diagnostic.severity[diagnostic.severity]
        local prefix = string.format(" %s ", signs.level )
        return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
      end
    },
    signs = true
  })
  require("lsp_lines").setup() -- override diagnostic handlers
  -- Update mappings when registering dynamic capabilites.
  local register_method = vim.lsp.protocol.Methods.client_registerCapability
  local register_capability = vim.lsp.handlers[register_method]
  vim.lsp.handlers[register_method] = function(err, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    if client then on_lsp_attach(client, ctx.bufnr) end
    return register_capability(err, result, ctx)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Configure LSP keymappings",
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client then on_lsp_attach(client, ev.buf) end
    end
  })
end

return M
