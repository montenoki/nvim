return {
    -- Logfile highlighter
    'fei6409/log-highlight.nvim',
    ft = { 'log' },
    config = function()
        require('log-highlight').setup({
            pattern = {
                '**/log/*.txt',
            },
        })
    end,
}
