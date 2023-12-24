local M = {}

local indent_normal = {
  char = '│',
  tab_char = '▏',
}
local indent_lite = {
  char = '|',
  tab_char = '|',
}

local diagnostics_normal = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}
local diagnostics_lite = {
  Error = 'E',
  Warn = 'W',
  Hint = 'H',
  Info = 'I',
}

local fillchars_normal = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
local fillchars_lite = {
  foldopen = 'v',
  foldclose = '>',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

local listchars_normal = {
  eol = '↲',
  tab = '▸ ',
  trail = '·',
  extends = '❯',
  precedes = '❮',
  -- space = "␣",
  nbsp = '␣',
}
local listchars_lite = {
  eol = '',
  tab = '',
  trail = '',
  extends = '',
  precedes = '',
  space = "",
  nbsp = '',
}
local git_normal = {
  -- Change type
  added = ' ',
  modified = ' ',
  removed = ' ',
  deleted = '✖', -- this can only be used in the git_status source
  renamed = '', -- this can only be used in the git_status source
  -- Status type
  untracked = '◌',
  ignored = '',
  unstaged = '󰄱',
  staged = '',
  conflict = '',
  unmerged = '',
}
local git_lite = {
  added = '[+]',
  modified = '[M]',
  removed = '[x]',
  deleted = '[x]',
  renamed = '[rn]',
  untracked = '[ ]',
  ignored = '[.]',
  unstaged = '[ ]',
  staged = '[v]',
  conflict = '[!]',
  unmerged = '[!]',
}

local bug_normal = '  '
local bug_lite = 'Bug'

local clock_normal = ' '
local clock_lite = ''

local lualine_normal = {
  nvim = '',
  symbols = {
    unix = '', -- e712
    dos = '', -- e70f
    mac = '', -- e711
  },
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
}
local lualine_lite = {
  nvim = 'NeoVim',
  symbols = {
    unix = 'LF',  -- e712
    dos = 'CRLF', -- e70f
    mac = 'CR',   -- e711
  },
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
}

local bufferline_normal = {
  buffer_close_icon = '󰅖',
  modified_icon = '●',
  close_icon = '',
  left_trunc_marker = '',
  right_trunc_marker = '',
  show_buffer_icons = true,
}
local bufferline_lite = {
  buffer_close_icon = 'x',
  modified_icon = 'o',
  close_icon = 'x',
  left_trunc_marker = '<-',
  right_trunc_marker = '->',
  show_buffer_icons = false,
}

local mason_normal = {
  package_installed = '✓',
  package_pending = '➜',
  package_uninstalled = '✗',
}
local mason_lite = {
  package_installed = 'v',
  package_pending = '>',
  package_uninstalled = 'x',
}

local navic_normal = {
  File = ' ',
  Module = '󰆧 ',
  Namespace = ' ',
  Package = '󰏗 ',
  Class = '𝓒 ',
  Method = 'ƒ ',
  Property = ' ',
  Field = '󰽐 ',
  Constructor = ' ',
  Enum = ' ',
  Interface = ' ',
  Function = '󰊕 ',
  Variable = '󰫧 ',
  Constant = '󰏿 ',
  String = '𝓐 ',
  Number = ' ',
  Boolean = '◩ ',
  Array = ' ',
  Object = '⦿ ',
  Key = ' ',
  Null = '󰟢 ',
  EnumMember = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
  separator = '> ',
}
local navic_lite = {
  File = '',
  Module = '',
  Namespace = '',
  Package = '',
  Class = '',
  Method = '',
  Property = '',
  Field = '',
  Constructor = '',
  Enum = '',
  Interface = '',
  Function = '',
  Variable = '',
  Constant = '',
  String = '',
  Number = '',
  Boolean = '',
  Array = '',
  Object = '',
  Key = '',
  Null = '',
  EnumMember = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
  separator = '',
}

local gitsigns_normal = {
  add = { text = '+▎' },
  change = { text = '▎' },
  delete = { text = '' },
  topdelete = { text = '' },
  changedelete = { text = '▎' },
  untracked = { text = 'U▎' },
}
local gitsigns_lite = {
  add = { text = '+|' },
  change = { text = 'C|' },
  delete = { text = '>' },
  topdelete = { text = '>' },
  changedelete = { text = '>' },
  untracked = { text = 'U|' },
}

local neotree_normal = {
  expander_collapsed = '',
  expander_expanded = '',
  folder_closed = '󰉋',
  folder_open = '󰝰',
  folder_empty = '󰉖',
  indent_marker = '│',
  last_indent_marker = '└',
  symlink = '',
  symlink_file = '',
  bookmark = '',
  file = '',
  symlink_arrow = '➔',
}
local neotree_lite = {
  expander_collapsed = '+',
  expander_expanded = '-',
  folder_closed = '= ',
  folder_open = '=:',
  folder_empty = '= ',
  indent_marker = '|',
  last_indent_marker = 'L',
  symlink = '',
  symlink_file = '',
  bookmark = '',
  file = '',
  symlink_arrow = '>',
}

local telescope_normal = {
  prompt_prefix = ' ',
  selection_caret = ' ',
}
local telescope_lite = {
  prompt_prefix = '>',
  selection_caret = '>',
}
local todo_comments_normal = {
  TODO = '',
  NOTE = '',
  WARN = '',
  FIX = '󰈸',
}
local todo_comments_lite = {
  TODO = 'v',
  NOTE = ':',
  WARN = '!',
  FIX = 'x',
}

local cmp_normal = {
  Array         = " ",
  Boolean       = "󰨙 ",
  Class         = " ",
  Codeium       = "󰘦 ",
  Color         = " ",
  Control       = " ",
  Collapsed     = " ",
  Constant      = "󰏿 ",
  Constructor   = " ",
  Copilot       = " ",
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = "󰊕 ",
  Interface     = " ",
  Key           = " ",
  Keyword       = " ",
  Method        = "󰊕 ",
  Module        = " ",
  Namespace     = "󰦮 ",
  Null          = " ",
  Number        = "󰎠 ",
  Object        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = " ",
  Reference     = " ",
  Snippet       = " ",
  String        = " ",
  Struct        = "󰆼 ",
  TabNine       = "󰏚 ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = "󰀫 ",
}
local cmp_lite = {
  Array         = "",
  Boolean       = "",
  Class         = "",
  Codeium       = "",
  Color         = "",
  Control       = "",
  Collapsed     = "",
  Constant      = "",
  Constructor   = "",
  Copilot       = "",
  Enum          = "",
  EnumMember    = "",
  Event         = "",
  Field         = "",
  File          = "",
  Folder        = "",
  Function      = "",
  Interface     = "",
  Key           = "",
  Keyword       = "",
  Method        = "",
  Module        = "",
  Namespace     = "",
  Null          = "",
  Number        = "",
  Object        = "",
  Operator      = "",
  Package       = "",
  Property      = "",
  Reference     = "",
  Snippet       = "",
  String        = "",
  Struct        = "",
  TabNine       = "",
  Text          = "",
  TypeParameter = "",
  Unit          = "",
  Value         = "",
  Variable      = "",
}

local ufo_normal = {
  suffix = '  %d ...'
}
local ufo_lite = {
  suffix = ' <- %d ...'
}

local noice_normal = {
  cmdline = '󰞷',
  search_down = '🔍⌄',
  search_up = '🔍⌃',
  filter = '󰈲',
  lua = '☾',
  help = '󰋖',
  IncRename = '⟳'
}
local noice_lite = {
  cmdline = '>',
  search_down = 'Search:',
  search_up = 'Search:',
  filter = '$:',
  lua = 'Lua:',
  help = '?',
  IncRename = ''
}
local lsp_normal = {
  diag_prefix = '󰣑',
  virtual_text_prefix = '●'
}

local lsp_lite = {
  diag_prefix = '>',
  virtual_text_prefix = '..'
}

if vim.g.lite_mode then
  M.bufferline = bufferline_lite
  M.diagnostics = diagnostics_lite
  M.lualine = lualine_lite
  M.git = git_lite
  M.clock = clock_lite
  M.bug = bug_lite
  M.indent = indent_lite
  M.mason = mason_lite
  M.navic = navic_lite
  M.gitsigns = gitsigns_lite
  M.neotree = neotree_lite
  M.telescope = telescope_lite
  M.todo_comments = todo_comments_lite
  M.cmp = cmp_lite
  M.ufo = ufo_lite
  M.fillchars = fillchars_lite
  M.listchars = listchars_lite
  M.noice = noice_lite
  M.lsp = lsp_lite
else
  M.bufferline = bufferline_normal
  M.diagnostics = diagnostics_normal
  M.lualine = lualine_normal
  M.git = git_normal
  M.clock = clock_normal
  M.bug = bug_normal
  M.indent = indent_normal
  M.mason = mason_normal
  M.navic = navic_normal
  M.gitsigns = gitsigns_normal
  M.neotree = neotree_normal
  M.telescope = telescope_normal
  M.todo_comments = todo_comments_normal
  M.cmp = cmp_normal
  M.ufo = ufo_normal
  M.fillchars = fillchars_normal
  M.listchars = listchars_normal
  M.noice = noice_normal
  M.lsp = lsp_normal
end

return M
