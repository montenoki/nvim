local Keys = require('keymaps')
return {
  'NeogitOrg/neogit',
  cond = vim.g.vscode == nil,
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },
  keys = {
    { Keys.neogit.toggle, '<CMD>Neogit<CR>', desc = 'NeoGit' },
  },
  config = true,
}
