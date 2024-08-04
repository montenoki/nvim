local icons = require('config').icons
local keymaps = require('keymaps')

return {
    {
        'SmiteshP/nvim-navic',
        lazy = true,
        opts = {
            icons = icons.kinds,
            lsp = {
                auto_attach = true,
                preference = nil,
            },
            highlight = true,
            depth_limit = 5,
            click = true,
        },
    },
    {
        'neovim/nvim-lspconfig',
        keys = {
            {
                keymaps.open.navbuddy,
                function()
                    require('nvim-navbuddy').open()
                end,
                mode = 'n',
                desc = 'Open Navbuddy',
            },
        },
        dependencies = {
            {
                'SmiteshP/nvim-navbuddy',
                dependencies = {
                    'SmiteshP/nvim-navic',
                    'MunifTanjim/nui.nvim',
                },
                opts = { lsp = { auto_attach = true } },
            },
        },
        -- your lsp config or other stuff
    },
    {
        'lualine.nvim',
        opts = function(_, opts)
            table.insert(opts.winbar.lualine_c, { 'navic' })
        end,
    },
}
