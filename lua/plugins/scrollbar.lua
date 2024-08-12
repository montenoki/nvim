return {
    {
        'petertriho/nvim-scrollbar',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
        dependencies = { 'kevinhwang91/nvim-hlslens' },
        init = function()
            vim.opt.virtualedit = 'onemore'
        end,
        opts = {
            show_in_active_only = true,
            handle = { blend = 0 },
            handlers = { gitsigns = true, search = true },
        },
    },
}
