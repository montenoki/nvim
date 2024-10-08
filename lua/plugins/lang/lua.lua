return {
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'stylua' })
            end
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'lua' })
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            codeLens = { enable = true },
                            completion = { callSnippet = 'Replace' },
                            doc = { privateName = { '^_' } },
                            hint = { enable = true },
                        },
                    },
                },
            },
        },
    },
    -- ===========================================================================
    -- formatter
    -- ===========================================================================
    {
        'stevearc/conform.nvim',
        opts = function(_, opts)
            local formater = { lua = { 'stylua' } }
            if type(opts.formatters_by_ft) == 'table' then
                opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft, formater)
            end
        end,
    },
}
