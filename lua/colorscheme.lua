if vim.g.lite then
  vim.cmd('colorscheme baretty')
else
  require('nightfox').load()
  vim.cmd('colorscheme carbonfox')
end
