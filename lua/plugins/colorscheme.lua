return {
  { 'EdenEast/nightfox.nvim', cond = vim.g.vscode == nil, lazy = true },
  {
    'rebelot/kanagawa.nvim',
    cond = vim.g.vscode == nil,
    lazy = true,
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },
}
