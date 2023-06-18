--[[
MIT License

Copyright (c) 2023 orumin
Copyright (c) 2021 ayamir

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

-- original code is taken from https://github.com/ayamir/nvimdots/blob/8631b662fe37dbfc2576aaf74a1d38d8ab71a2a3/lua/modules/utils/icons.lua

local settings = require("configs.global_settings")
local function get_icon(arg)
  if type(arg) ~= "table" or #arg ~= 2 then
    return " "
  end
  return settings.icon.nerd_ver == "2" and arg[1] or
    settings.icon.nerd_ver == "3" or arg[2] or
    "?"
end
local icons = {}

local data = {
  kind = {
    Class = get_icon({"ﴯ", "󰠱"}),
    Color = get_icon({"", "󰏘"}),
    Constant = get_icon({"", "󰏿"}),
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = get_icon({"", "󰇽"}),
    File = get_icon({"", "󰈙"}),
    Folder = get_icon({"", "󰉋"}),
    Function = get_icon({"", "󰊕"}),
    Interface = "",
    Keyword = get_icon({"", "󰌋"}),
    Method = get_icon({"", "󰆧"}),
    Module = "",
    Namespace = get_icon({"", "󰌗"}),
    Number = "",
    Operator = get_icon({"", "󰆕"}),
    Package = "",
    Property = get_icon({"ﰠ", "󰜢"}),
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = get_icon({"", "󰉿"}),
    TypeParameter = get_icon({"", "󰅲"}),
    Undefined = "",
    Unit = "",
    Value = get_icon({"", "󰎠"}),
    Variable = "",
    -- ccls-specific icons.
    TypeAlias = "",
    Parameter = "",
    StaticMethod = "",
    Macro = "",
  },
  type = {
    Array = get_icon({"", "󰅪"}),
    Boolean = "",
    Null = get_icon({"ﳠ", "󰟢"}),
    Number = "",
    Object = get_icon({"", "󰅩"}),
    String = get_icon({"", "󰉿"}),
  },
  documents = {
    Default = "",
    File = "",
    Files = "",
    FileTree = get_icon({"פּ", "󰙅"}),
    Import = "",
    Symlink = "",
  },
  git = {
    Add = "",
    Branch = "",
    Diff = "",
    Git = get_icon({"", "󰊢"}),
    Ignore = "",
    Mod = "M",
    Mod_alt = "",
    Remove = "",
    Rename = "",
    Repo = "",
    Unmerged = get_icon({"שׂ", "󰘬"}),
    Untracked = get_icon({"ﲉ", "󰞋"}),
    Unstaged = "",
    Staged = "",
    Conflict = "",
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    BigCircle = "",
    BigUnfilledCircle = "",
    BookMark = get_icon({"", "󰃃"}),
    Bug = "",
    Calendar = "",
    Check = get_icon({"", "󰄳"}),
    ChevronRight = "",
    Circle = "",
    Close = get_icon({"", "󰅖"}),
    Close_alt = "",
    CloudDownload = "",
    Comment = get_icon({"", "󰅺"}),
    CodeAction = get_icon({"", "󰌵"}),
    Dashboard = "",
    Emoji = get_icon({"", "󰱫"}),
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = get_icon({"", "󰈤"}),
    Fire = "",
    Folder = "",
    FolderOpen = "",
    Gear = "",
    History = get_icon({"", "󰄉"}),
    Incoming = get_icon({"", "󰏷"}),
    Indicator = "",
    Keyboard = "",
    Left = "",
    List = "",
    Square = "",
    SymlinkFolder = "",
    Lock = get_icon({"", "󰍁"}),
    Modified = "✥",
    Modified_alt = "",
    NewFile = "",
    Newspaper = "",
    Note = get_icon({"", "󰍨"}),
    Outgoing = get_icon({"", "󰏻"}),
    Package = "",
    Pencil = get_icon({"", "󰏫"}),
    Perf = get_icon({"", "󰅒"}),
    Play = "",
    Project = "",
    Right = "",
    RootFolderOpened = "",
    Search = get_icon({"", "󰍉"}),
    Separator = "",
    DoubleSeparator = get_icon({"", "󰄾"}),
    SignIn = "",
    SignOut = "",
    Sort = "",
    Spell = get_icon({"暈", "󰓆"}),
    Symlink = "",
    Table = "",
    Telescope = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = get_icon({"", "󰌵"}),
    -- Holo version
    Error_alt = get_icon({"", "󰅚"}),
    Warning_alt = get_icon({"", "󰀪"}),
    Information_alt = "",
    Question_alt = "",
    Hint_alt = get_icon({"", "󰌶"}),
  },
  misc = {
    Campass = get_icon({"", "󰀹"}),
    Code = "",
    EscapeST = "",
    Gavel = "",
    Glass = get_icon({"", "󰂖"}),
    PyEnv = get_icon({"", "󰌠"}),
    Squirrel = "",
    Tag = "",
    Tree = "",
    Watch = "",
    Lego = "",
    Vbar = "│",
    Add = "+",
    Added = "",
    Ghost = get_icon({"", "󰊠"}),
    ManUp = "",
    Vim = "",
  },
  cmp = {
    -- Add source-specific icons here
    buffer = "",
    cmp_tabnine = "",
    codeium = "",
    copilot = "",
    copilot_alt = "",
    latex_symbols = "",
    luasnip = get_icon({"", "󰃐"}),
    nvim_lsp = "",
    nvim_lua = "",
    orgmode = "",
    path = "",
    spell = get_icon({"暈", "󰓆"}),
    tmux = "",
    treesitter = "",
    undefined = "",
  },
  dap = {
    Breakpoint = get_icon({"", "󰝥"}),
    BreakpointCondition = get_icon({"ﳁ", "󰟃"}),
    BreakpointRejected = "",
    LogPoint = "",
    Pause = "",
    Play = "",
    RunLast = "↻",
    StepBack = "",
    StepInto = get_icon({"", "󰆹"}),
    StepOut = get_icon({"", "󰆸"}),
    StepOver = get_icon({"", "󰆷"}),
    Stopped = "",
    Terminate = get_icon({"ﱢ", "󰝤"}),
  },
}

if settings.icon.nerd_ver == "2" then
  vim.fn.setcellwidths({{0xf500, 0xfd46, 2}})
end

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"
---@param add_space? boolean @Add trailing space after the icon.
function icons.get(category, add_space)
  if add_space then
    return setmetatable({}, {
      __index = function(_, key)
        return data[category][key] .. " "
      end,
    })
  else
    return data[category]
  end
end

return icons
