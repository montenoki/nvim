local Keys = require('keymaps').pairs
local Lazyvim = require('lazyvim')

return {
  'echasnovski/mini.pairs',
  event = { 'VeryLazy', 'InsertEnter' },
  opts = {},
  keys = {
    {
      Keys.toggle,
      function()
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          Lazyvim.warn('Disabled auto pairs', { title = 'Option' })
        else
          Lazyvim.info('Enabled auto pairs', { title = 'Option' })
        end
      end,
      desc = 'Toggle auto pairs',
    },
  },
}
