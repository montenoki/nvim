return {
  'smjonas/inc-rename.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  config = function()
    require('inc_rename').setup()
  end,
}
