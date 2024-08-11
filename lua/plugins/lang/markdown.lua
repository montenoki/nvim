local keymaps = require('keymaps')

return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    },
    {
        'stevearc/conform.nvim',
        opts = function(_, opts)
            local markdown_formater = { markdown = { 'prettier' } }
            if type(opts.formatters_by_ft) == 'table' then
                opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft, markdown_formater)
            end
        end,
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { 'marksman', 'prettier' })
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = 'cd app && npm install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        keys = {
            {
                keymaps.markdown.preview,
                ft = 'markdown',
                '<cmd>MarkdownPreviewToggle<cr>',
                desc = 'Markdown Preview',
            },
        },
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                marksman = {},
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'markdown', 'markdown_inline' })
            end
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        version = '*', -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = 'markdown',
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        --   -- refer to `:h file-pattern` for more examples
        --   "BufReadPre path/to/my-vault/*.md",
        --   "BufNewFile path/to/my-vault/*.md",
        -- },
        dependencies = {
            -- Required.
            'nvim-lua/plenary.nvim',

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/TensNote',
                },
            },

            -- see below for full list of options 👇
        },
    },
}
