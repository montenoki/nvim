local Keys = require('keymaps')
return {
  'gorbit99/codewindow.nvim',
  config = function()
    local codewindow = require('codewindow')
    vim.keymap.set('n', Keys.minimap.toggle, codewindow.toggle_minimap, {desc='toggle the minimap'})
    codewindow.setup()
  end,
}
