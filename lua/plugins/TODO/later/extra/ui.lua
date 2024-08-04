return {
  -- Scroll Bar
  {
    'petertriho/nvim-scrollbar',
    enabled = false,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    cond = vim.g.lite == nil and vim.g.vscode == nil,
    opts = {
      show_in_active_only = true,
      handle = { blend = 25 },
      handlers = { gitsigns = true },
    },
  },
}
