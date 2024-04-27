return {
  'smjonas/inc-rename.nvim',
  cond = vim.g.vscode == nil,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  config = function()
    ---@diagnostic disable-next-line: missing-parameter
    require('inc_rename').setup()
  end,
}
