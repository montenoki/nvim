local keymaps = require('keymaps')

return {
    'gorbit99/codewindow.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {},
    config = function()
        local codewindow = require('codewindow')
        codewindow.setup()
        vim.keymap.set('n', keymaps.open.miniMap, codewindow.toggle_minimap, { desc = 'Open minimap' })
    end,
}
