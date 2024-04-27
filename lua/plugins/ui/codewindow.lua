local Keys = require('keymaps')

return {
  'gorbit99/codewindow.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  cond = vim.g.vscode == nil,
  opts = {},
  config = function()
    local codewindow = require('codewindow')
    vim.keymap.set('n', Keys.minimap.toggle, codewindow.toggle_minimap, { desc = 'toggle the minimap' })
    codewindow.setup()
  end,
}
