return {
    -- ===========================================================================
    -- lsp
    -- ===========================================================================
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = { powershell_es = {} },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = { ensure_installed = { 'powershell' } },
    },
}
