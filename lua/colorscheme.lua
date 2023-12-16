if vim.g.lite_mode then
  vim.o.background = 'light'
  -- require('16-colors').load() -- TODO[2023/12/12]: config lite mode colorscheme
else
  math.randomseed(os.time())
  local colorschemes = { 'dracula', 'tokyonight', 'gruvbox', 'nightfox'}
  require(colorschemes[math.random(#colorschemes)]).load()
end
