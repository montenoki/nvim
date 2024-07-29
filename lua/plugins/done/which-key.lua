local keymaps = require('keymaps')

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons' },
  opts = {
    spec = {
      { '<LEADER>t', group = 'Tag' },
      { '<LEADER>w', group = 'Windows' },
      { '<LEADER>u', group = 'Toggle' },
    },
  },
  keys = {
    {
      keymaps.whichkey.show,
      mode = { 'n', 'i', 'x' },
      function()
        require('which-key').show()
      end,
      desc = 'Show Which-key',
    },
  },
}
