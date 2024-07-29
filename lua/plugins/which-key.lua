local keymaps = require('keymaps')

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  dependencies = { 'echasnovski/mini.icons', 'nvim-tree/nvim-web-devicons' },
  opts = {
    spec = {
      { '<leader>w', group = 'Windows' },
      { '<leader>u', group = 'Toggle' },
    },
  },
  keys = {
    {
      keymaps.whichkey.show,
      mode = { 'n', 'i' },
      function()
        require('which-key').show()
      end,
      desc = 'Show Keymaps',
    },
    {
      keymaps.whichkey.showLocal,
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Show Local Keymaps',
    },
  },
}
