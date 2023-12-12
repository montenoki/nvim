local M = {}

local indent_normal = {
  char = '│',
  tab_char = "▏",
}
local indent_lite = {
  char = '|',
  tab_char = '|',
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

local diagnostics_normal = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
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
local clock_lite = 'Now:'

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

if vim.g.lite_mode then
  M.bufferline = bufferline_lite
  M.diagnostics = diagnostics_lite
  M.lualine = lualine_lite
  M.git = git_lite
  M.clock = clock_lite
  M.bug = bug_lite
  M.indent = indent_lite
else
  M.bufferline = bufferline_normal
  M.diagnostics = diagnostics_normal
  M.lualine = lualine_normal
  M.git = git_normal
  M.clock = clock_normal
  M.bug = bug_normal
  M.indent = indent_normal
end

return M
