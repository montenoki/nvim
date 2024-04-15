return {
  'nvim-tree/nvim-web-devicons',
  lazy = true,
  cond = vim.g.vscode == nil and vim.g.lite == nil,
}
