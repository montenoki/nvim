local Keys = require('keymaps').whichkey

return {
  'folke/which-key.nvim',
  cond = vim.g.vscode == nil,
  event = 'VeryLazy',
  keys = {
    { Keys.toggle_wk, '<CMD>WhichKey<CR>' },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
  end,
}
