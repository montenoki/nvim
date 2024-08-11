local keymaps = require('keymaps')

return {
    {
        'hotoo/pangu.vim',
        lazy = true,
        keys = { { keymaps.format.format_cjk, '<CMD>PanguAll<CR>', { desc = 'Format CJK' } } },
    },
}
