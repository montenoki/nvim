if vim.g.lite_mode then
  vim.o.background = 'light'
else
  require('dracula').load()
end
