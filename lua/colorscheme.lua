if vim.g.lite_mode then
  vim.o.background = 'light'
  -- require('16-colors').load()
else
  require('dracula').load()
end
