local Ascii_icons = require('util.ascii_icons')
return {
  'lukas-reineke/indent-blankline.nvim',
  cond = false,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  opts = {
    indent = vim.g.lite == nil and { char = '│', tab_char = '▏' } or Ascii_icons.indent,
    scope = { enabled = false },
    exclude = {
      -- stylua: ignore
      filetypes = {
        'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'trouble',
        'lazy', 'mason', 'notify', 'toggleterm', 'lazyterm',
      },
    },
  },
  main = 'ibl',
}
