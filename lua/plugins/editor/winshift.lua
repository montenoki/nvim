local Keys = require('keymaps').window

return {
  'sindrets/winshift.nvim',
  cond = vim.g.vscode == nil,
  lazy = true,
  keys = {
    { Keys.move_windows, '<CMD>WinShift<CR>', desc = 'Move windows' },
  },
}
