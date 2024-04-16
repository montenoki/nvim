local M = {}

M.listchars = 'eol:$,tab:<->,trail:~,extends:>,precedes:<'
M.lsp = {
  diag_prefix = '>',
  virtual_text_prefix = '..',
}
M.mason = {
  package_installed = 'v',
  package_pending = '>',
  package_uninstalled = 'x',
}
M.diagnostics = {
  Error = 'E',
  Warn = 'W',
  Hint = 'H',
  Info = 'I',
}
M.virtual_text_prefix = '..'
M.lualine = {
  section_separators = { left = '', right = '' },
}
M.nvimtree = {
  indent_markers = {
    corner = 'L',
    edge = '|',
    item = '|',
    bottom = 'L',
  },
  symlink_arrow = '>',
  glyphs = {
    default = '',
    symlink = '',
    bookmark = '',
    modified = '.',
    folder = {
      arrow_closed = '+',
      arrow_open = '-',
      default = '+',
      open = '=:',
      empty = '= ',
      empty_open = '= ',
      symlink = '',
      symlink_open = '',
    },
    git = M.git,
  },
  diagnostics = {
    hint = M.diagnostics.Hint,
    info = M.diagnostics.Info,
    warning = M.diagnostics.Warn,
    error = M.diagnostics.Error,
  },
}
M.git = {
  added = '[+]',
  modified = '[M]',
  removed = '[-]',
  deleted = '[x]',
  renamed = '[rn]',
  untracked = '[ ]',
  ignored = '[.]',
  unstaged = '[ ]',
  staged = '[v]',
  conflict = '[!]',
  unmerged = '[!]',
}
M.gitsigns = {
  add = { text = '+|' },
  change = { text = 'C|' },
  delete = { text = '>' },
  topdelete = { text = '>' },
  changedelete = { text = '>' },
  untracked = { text = 'U|' },
}
M.bufferline = {
  left_trunc_marker = '<|',
  right_trunc_marker = '|>',
}
M.indent = {
  char = '|',
  tab_char = '|',
}

M.ufo = {
  suffix = ' <- %d ...',
}
return M
