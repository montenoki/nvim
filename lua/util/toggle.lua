local M = {}

function M.wrap()
  -- if this Neovim version supports checking if diagnostics are enabled
  -- then use that for the current state
  if vim.o.wrap then
    vim.cmd('set wrap')
    require('lazyvim').warn('Disabled diagnostics', { title = 'Diagnostics' })
  else
    vim.cmd('set wrap')
    require('lazyvim').info('Enabled diagnostics', { title = 'Diagnostics' })
  end
end
return M
