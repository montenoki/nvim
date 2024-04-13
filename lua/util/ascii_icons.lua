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

return M
