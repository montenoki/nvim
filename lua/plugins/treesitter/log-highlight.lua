return {
  -- Logfile highlighter
  'fei6409/log-highlight.nvim',
  cond = vim.g.vscode == nil,
  lazy = true,
  ft = { "log"},
  config = function()
    require('log-highlight').setup({})
  end,
}
