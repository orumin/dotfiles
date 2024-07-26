local uv = vim.uv

---@diagnostic disable: duplicate-doc-field
---@class GlobalEnvs<T> { [string]: T }

---@class globals : GlobalEnvs<boolean>
---@field pr_info fun(msg: string, opts: table?)
---@field pr_warn fun(msg: string, opts: table?)
---@field pr_error fun(msg: string, opts: table?)
---@field is_headless boolean
---@field gui_running boolean
---@field is_win boolean
---@field is_mac boolean
---@field is_linux boolean
---@field is_wsl boolean
---@field path_sep string
---@field homedir string
---@field config_home string
---@field nvim_cache_dir string
---@field nvim_config_dir string
---@field nvim_data_dir string
---@field nvim_state_dir string
---@field plugin_config_dir string
---@field cli_browser string
---@field cli_rich_browser string
---@field browser string

---@class G : globals
---@field protected cached boolean

---@class utils : G
---@field private setting_global fun(self: utils)
---@field globals fun(self: utils): globals
---@field get_palette fun(): { [string]: string }
---@field get_root fun(): string
---@field get_keymap_opts fun(table): table
---@field path_concat fun(self: utils, dir_table: string[]): string
---convert windows path to unix path. if you use unix, return passed string without modify
---@field path_convert fun(self: utils, win_path: string): string
---@field mkdir_p fun(self: utils, path: string, mode: integer): (success: boolean?, err_name: string?, err_msg: string?)

---@type utils
---@diagnostic disable-next-line: missing-fields
local M = {
  G = {
    globals = {
      pr_info = function (msg, opts)
        vim.notify(msg, vim.log.levels.INFO, opts)
      end,

      pr_warn = function (msg, opts)
        vim.notify(msg, vim.log.levels.WARN, opts)
      end,

      pr_error = function (msg, opts)
        vim.notify(msg, vim.log.levels.ERROR, opts)
      end
    },
    cached = false
  },
  S_IRWXU = 0x1C0, -- 0700 (octal) '(S_IRUSR | S_IWUSR | S_IXUSR)'
  S_IRUSR = 0x100, -- 0400 (octal) read permission for the owner of the file
  S_IWUSR = 0x080, -- 0200 (octal) write permission for the owner of the file
  S_IXUSR = 0x040, -- 0100 (octal) execute or search permission bit for the owner of the file
  S_IREAD = 0x100, -- 0400 (octal) read permission for the owner of the file
  S_IWRITE = 0x080, -- 0200 (octal) write permission for the owner of the file
  S_IEXEC = 0x100, -- 0400 (octal) read permission for the owner of the file

  S_IRWXG = 0x038, -- 0070 (octal) '(S_IRGRP | S_IWGRP | S_IXGRP)'
  S_IRGRP = 0x020, -- 0040 (octal) read permission for the group owner of the file
  S_IWGRP = 0x010, -- 0020 (octal) write permission for the group owner of the file
  S_IXGRP = 0x008, -- 0010 (octal) execute or search pewrmission bit for the group owner of the file

  S_IWRXO = 0x007, -- 0007 (octal) '(S_IROTH | S_IWOTH | S_IXOTH)'
  S_IROTH = 0x004, -- 0004 (octal) read permission bit for other users
  S_IWOTH = 0x002, -- 0002 (octal) write permission bit for other users
  S_IXOTH = 0x001, -- 0001 (octal) execute or search permission bit for other users

  S_ISUID = 0x800, -- 4000 (octal) set-user-ID
  S_ISGID = 0x400, -- 2000 (octal) set-group-ID
  S_ISVTX = 0x200, -- 1000 (octal) sticky-bit
}

---@diagnostic disable-next-line: invisible
function M:setting_global()
  local uname = uv.os_uname()

  local uis = vim.api.nvim_list_uis() or {}
  local n_ui = 0
  for _ in pairs(uis) do n_ui = n_ui + 1 end

  self.G.globals["is_headless"] = n_ui == 0
  self.G.globals["gui_running"] = vim.fn.has("gui_running") == 1
  self.G.globals["is_win"] = uname.sysname == "Windows" or uname.sysname == "Windows_NT"
  self.G.globals["is_mac"] = uname.sysname == "Darwin"
  self.G.globals["is_linux"] = uname.sysname == "Linux"
  self.G.globals["is_wsl"] = self.G.globals["is_linux"] and string.find(uname.release, "microsoft") ~= nil
  self.G.globals["path_sep"] = self.G.globals["is_win"] and "\\" or "/"
  self.G.globals["homedir"] = uv.os_homedir()
  if vim.env.XDG_CONFIG_HOME then
    self.G.globals["config_home"] = vim.env.XDG_CONFIG_HOME
  else
    self.G.globals["config_home"] = table.concat({self.G.globals["homedir"], ".config"}, self.G.globals["path_sep"])
  end

  self.G.globals["nvim_cache_dir"] = vim.fn.stdpath("cache")
  self.G.globals["nvim_config_dir"] = vim.fn.stdpath("config")
  self.G.globals["nvim_data_dir"] = vim.fn.stdpath("data")
  self.G.globals["nvim_state_dir"] = vim.fn.stdpath("state")
  self.G.globals["plugin_config_dir"] = table.concat({self.G.globals["nvim_config_dir"], "lua", "configs", "plugin"}, self.G.globals["path_sep"])

  if vim.fn.executable("w3m") == 1 then
    self.G.globals["cli_browser"] = "w3m"
  elseif vim.fn.executable("lynx") == 1 then
    self.G.globals["cli_browser"] = "lynx"
  elseif vim.fn.executable("links") == 1 then
    self.G.globals["cli_browser"] = "links"
  end

  if vim.fn.executable("carbonyl") == 1 then
    self.G.globals["cli_rich_browser"] = "carbonyl"
  elseif vim.fn.executable("browsh") == 1 then
    self.G.globals["cli_rich_browser"] = "browsh"
  end

  self.G.globals["browser"] = vim.env.BROWSER and vim.env.BROWSER or "vivaldi"
end

function M:globals()
  if not self.G.cached then
    self:setting_global()
    self.G.cached = true
  end
  return self.G.globals
end

function M.get_root()
  local path = uv.fs_realpath(vim.api.nvim_buf_get_name(0))
  ---@type string[]
  local roots = {}
  if path ~= "" then
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      local root_dir = client.config.root_dir
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.iter(workspace):map(function(v) return vim.uri_to_fname(v.uri) end):totable() or
                    root_dir and { root_dir } or
                    {}
      for _, p in ipairs(paths) do
        local r = uv.fs_realpath(p)
        if r and path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  ---@type string?
  local root = roots[1]
  if not root then
    path = path == "" and uv.cwd() or vim.fs.dirname(path)
    root = vim.fs.find({ ".git" }, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or uv.cwd()
  end
  ---@cast root string
  return root
end

function M.get_palette()
  local ok, catppuccin_palettes = pcall(require, "catppuccin.palettes")
  local palette = nil
  if ok then
    palette = catppuccin_palettes.get_palette()
  end

  if not palette then
    palette = {
      rosewater = "#f5e0dc",
      flamingo =  "#f2cdcd",
      pink =      "#f5c2e7",
      mauve =     "#cba6f7",
      red =       "#f38ba8",
      maroon =    "#eba0ac",
      peach =     "#fab387",
      yellow =    "#f9e2af",
      green =     "#a6e3a1",
      teal =      "#94e2d5",
      sky =       "#89dceb",
      sapphire =  "#74c7ec",
      blue =      "#89b4fa",
      lavender =  "#b4befe",
      text =      "#cdd6f4",
      subtext1 =  "#bac2de",
      subtext0 =  "#a6adc8",
      overlay2 =  "#9399b2",
      overlay1 =  "#7f849c",
      overlay0 =  "#6c7086",
      surface2 =  "#585b70",
      surface1 =  "#45475a",
      surface0 =  "#313244",
      base =      "#1e1e2e",
      mantle =    "#181825",
      crust =     "#11111b",
    }
  end

  return palette
end

function M.get_keymap_opts(keys)
  local skip = { mode = true, ft = true, rhs = true, lhs = true }
  local ret = {}
  for k, v in pairs(keys) do
    if type(k) ~= "number" and not skip[k] then
      ret[k] = v
    end
  end
  return ret
end

--function M.open_float_term()
--  local current_width=vim.api.nvim_win_get_width(0)
--  local current_height=vim.api.nvim_win_get_height(0)
--  local ratio = 0.8
--  local width=math.ceil(current_width*ratio)
--  local height=math.ceil(current_height*ratio)
--  local col=math.ceil((current_width-width) / 2-1)
--  local row=math.ceil((current_height-height) / 2-1)
--
--  local opts = {
--    border=configs.window_style.border,
--    width=width,
--    height=height,
--    relative='editor',
--    col=col,
--    row=row,
--    style="minimal"
--  }
--
--  local bufnr = vim.api.nvim_create_buf(false, true)
--  local winnr = vim.api.nvim_open_win(bufnr, true, opts)
--
--  vim.wo[winnr].winblend = 0
--  vim.bo[bufnr].bufhidden = "wipe"
--  vim.bo[bufnr].filetype = "terminal"
--
--  local chan = vim.api.nvim_open_term(bufnr, {})
--  vim.fn.jobstart(vim.env.SHELL, {
--    pty = 1,
--    on_stdout = function (_, data, _)
--      for _, d in ipairs(data) do
--        vim.api.nvim_chan_send(chan, d .. "\r\n")
--      end
--    end
--  })
--end

function M:path_concat(dir_table)
  if not dir_table or type(dir_table) ~= "table" then
    return ""
  end

  return table.concat(dir_table, self:globals().path_sep)
end

function M:path_convert(win_path)
  local ret = win_path
  if self:globals().is_win then
    local drive_letter = win_path:match("^(%w+):")
    ret = win_path:gsub("\\", "/")
    if drive_letter then
      ---@cast drive_letter string
      ret = ret:gsub("^%w+:", "/" .. drive_letter:lower())
    end
  end
  return ret
end

function M:mkdir_p(path, mode)
  local success, err_name, err_msg = vim.uv.fs_mkdir(path, mode)
  if success then
    return true
  elseif err_name and string.match(err_name, "^EEXIST") then
    return true
  elseif err_name and string.match(err_name, "^ENOENT") then
    success, err_name, err_msg = vim.uv.fs_mkdir(M:path_concat({path, ".."}), mode)
    if not success then return false, err_name, err_msg  end
    return vim.uv.fs_mkdir(path, mode)
  end

  return false, err_name, err_msg
end

return M
