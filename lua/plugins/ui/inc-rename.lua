return {
  'smjonas/inc-rename.nvim',
  cond = vim.g.vscode == nil,
  config = function()
    require('inc_rename').setup()
  end,
}
