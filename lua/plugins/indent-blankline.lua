return {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
    opts = {
        indent = { char = '│', tab_char = '▏' },
        scope = { enabled = false },
        exclude = {
            -- stylua: ignore
            filetypes = {
            'help', 'alpha', 'dashboard', 'Trouble', 'trouble',
            'lazy', 'mason', 'notify', 'toggleterm', 'lazyterm',
            },
        },
    },
    main = 'ibl',
}
