local keymaps = require('keymaps')

return {
    'NeogitOrg/neogit',
    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        {
            'sindrets/diffview.nvim',
            cmd = { 'DiffviewOpen', 'DiffviewToggleFiles', 'DiffviewFileHistory' },
        }, -- optional - Diff integration
        'nvim-telescope/telescope.nvim', -- optional
    },
    keys = {
        { keymaps.open.neogit, '<CMD>Neogit<CR>', desc = 'NeoGit' },
    },
    config = true,
}
