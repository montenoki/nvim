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

local git_normal = {
  added = ' ',
  modified = ' ',
  removed = ' ',
}
local git_lite = {
  added = 'A',
  modified = 'M',
  removed = 'D',
}

local bug_normal = '  '
local bug_lite = 'Bug'

local clock_normal = ' '
local clock_lite = ''

local lualine_normal = {
  symbols = {
    unix = '', -- e712
    dos = '', -- e70f
    mac = '', -- e711
  },
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
}
local lualine_lite = {
  symbols = {
    unix = 'LF', -- e712
    dos = 'CRLF', -- e70f
    mac = 'CR', -- e711
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
end

return M
