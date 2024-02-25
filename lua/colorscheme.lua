if vim.g.lite_mode then
  vim.cmd('colorscheme baretty')
else
  require('nightfox').load()
  vim.cmd('colorscheme carbonfox')
end
