local keymaps = require('keymaps')

return {
    'sindrets/winshift.nvim',
    keys = {
        { keymaps.open.moveWindow, '<CMD>WinShift<CR>', desc = 'Move window' },
    },
}
