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

return M
