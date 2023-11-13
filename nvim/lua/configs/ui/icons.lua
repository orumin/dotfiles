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

local icons = {}

local data = {
  kind = {
    Class = "󰠱",
    Color = "󰏘",
    Component = "󰅴",
    Constant = "󰏿",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "󰇽",
    File = "󰈙",
    Folder = "󰉋",
    Fragment = "󰅴",
    Function = "󰊕",
    Interface = "",
    Keyword = "󰌋",
    Method = "󰆧",
    Module = "",
    Namespace = "󰌗",
    Number = "",
    Operator = "󰆕",
    Package = "",
    Property = "󰜢",
    Reference = "",
    Snippet = "",
    Struct = "",
    Text = "󰉿",
    TypeParameter = "󰅲",
    Undefined = "",
    Unit = "",
    Value = "󰎠",
    Variable = "",
    -- ccls-specific icons.
    TypeAlias = "",
    Parameter = "",
    StaticMethod = "",
    Macro = "",
  },
  type = {
    Array = "󰅪",
    Boolean = "",
    Null = "󰟢",
    Number = "",
    Object = "󰅩",
    String = "󰉿",
  },
  documents = {
    Default = "",
    File = "",
    Files = "",
    FileTree = "󰙅",
    Import = "",
    Symlink = "",
  },
  git = {
    Add = "",
    Branch = "",
    Diff = "",
    Git = "󰊢",
    Ignore = "",
    Mod = "M",
    Mod_alt = "",
    Remove = "",
    Rename = "",
    Repo = "",
    Unmerged = "󰘬",
    Untracked = "󰞋",
    Unstaged = "",
    Staged = "",
    Conflict = "",
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    BigCircle = "",
    BigUnfilledCircle = "",
    BookMark = "󰃃",
    Bug = "",
    Calendar = "",
    Check = "󰄳",
    ChevronRight = "",
    Circle = "",
    Close = "󰅖",
    Close_alt = "",
    CloudDownload = "",
    Comment = "󰅺",
    CodeAction = "󰌵",
    Dashboard = "",
    Emoji = "󰱫",
    EmptyFolder = "",
    EmptyFolderOpen = "",
    File = "󰈤",
    Fire = "",
    Folder = "",
    FolderOpen = "",
    Gear = "",
    History = "󰄉",
    Incoming = "󰏷",
    Indicator = "",
    Keyboard = "",
    Left = "",
    List = "",
    Square = "",
    SymlinkFolder = "",
    Lock = "󰍁",
    Modified = "✥",
    Modified_alt = "",
    NewFile = "",
    Newspaper = "",
    Note = "󰍨",
    Outgoing = "󰏻",
    Package = "",
    Pencil = "󰏫",
    Perf = "󰅒",
    Play = "",
    Project = "",
    Right = "",
    RootFolderOpened = "",
    Search = "󰍉",
    Separator = "",
    DoubleSeparator = "󰄾",
    SignIn = "",
    SignOut = "",
    Sort = "",
    Spell = "󰓆",
    Symlink = "",
    Table = "",
    Telescope = "",
  },
  codicons = {
    Compound = "",
    Declaration = "",
    Expression = "",
    PackExpansion = "",
    Specifier = "",
    Statement = "",
    TemplateParm = "",
    TranslationUnit = "",
    Type = "",
  },
  diagnostics = {
    Error = "",
    Warning = "",
    Information = "",
    Question = "",
    Hint = "󰌵",
    -- Holo version
    Error_alt = "󰅚",
    Warning_alt = "󰀪",
    Information_alt = "",
    Question_alt = "",
    Hint_alt = "󰌶",
  },
  misc = {
    Add = "+",
    Added = "",
    Campass = "󰀹",
    Code = "",
    EscapeST = "",
    FreeBSD = "",
    Gavel = "",
    Ghost = "󰊠",
    Glass = "󰂖",
    Illumos = "",
    Lego = "",
    Linux = "",
    Macos = "",
    ManUp = "",
    NetBSD = "",
    PyEnv = "󰌠",
    OpenBSD = "",
    Squirrel = "",
    Tag = "",
    Tree = "",
    Vbar = "│",
    Vim = "",
    Watch = "",
    Windows = "",
  },
  cmp = {
    -- Add source-specific icons here
    buffer = "",
    cmp_tabnine = "",
    codeium = "",
    copilot = "",
    copilot_alt = "",
    latex_symbols = "",
    luasnip = "󰃐",
    nvim_lsp = "",
    nvim_lua = "",
    orgmode = "",
    path = "",
    spell = "󰓆",
    tmux = "",
    treesitter = "",
    undefined = "",
  },
  dap = {
    Breakpoint = "󰝥",
    BreakpointCondition = "󰟃",
    BreakpointRejected = "",
    LogPoint = "",
    Pause = "",
    Play = "",
    RunLast = "↻",
    StepBack = "",
    StepInto = "󰆹",
    StepOut = "󰆸",
    StepOver = "󰆷",
    Stopped = "",
    Terminate = "󰝤",
  },
}

---Get a specific icon set.
---@param category "kind"|"type"|"documents"|"git"|"ui"|"diagnostics"|"misc"|"cmp"|"dap"|"codicons"
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
