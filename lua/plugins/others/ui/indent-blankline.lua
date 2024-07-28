return {
  'lukas-reineke/indent-blankline.nvim',
  cond = vim.g.vscode == nil and vim.g.lite == nil,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  opts = {
    indent = { char = '│', tab_char = '▏' },
    scope = { enabled = false },
    exclude = {
      -- stylua: ignore
      filetypes = {
        'help', 'alpha', 'dashboard', 'Trouble', 'trouble',
        'lazy', 'mason', 'notify', 'toggleterm', 'lazyterm',
      },
    },
  },
  main = 'ibl',
}
