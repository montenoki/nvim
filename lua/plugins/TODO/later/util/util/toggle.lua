local M = {}
local Lazyvim = require('lazyvim')

function M.wrap()
  -- if this Neovim version supports checking if diagnostics are enabled
  -- then use that for the current state
  if vim.o.wrap then
    vim.cmd('set wrap')
    Lazyvim.warn('Disabled diagnostics', { title = 'Diagnostics' })
  else
    vim.cmd('set wrap')
    Lazyvim.info('Enabled diagnostics', { title = 'Diagnostics' })
  end
end
function M.treesitter()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
    Lazyvim.warn('Disabled Treesitter Highlight', { title = 'Option' })
  else
    vim.treesitter.start()
    Lazyvim.info('Enabled Treesitter Highlight', { title = 'Option' })
  end
end
return M
