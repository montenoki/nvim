return {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = { 'CmdlineEnter' },
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'dmitmel/cmp-cmdline-history',
    },
    opts = function()
        vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
        local cmp = require('cmp')
        -- local defaults = require('cmp.config.default')()
        return {
            -- completion = {
            --     completeopt = 'menu,menuone,noselect',
            -- },
            preselect = cmp.PreselectMode.None,
            -- sources = cmp.config.sources(),
            -- experimental = { ghost_text = { hl_group = 'CmpGhostText' } },
            -- sorting = defaults.sorting,
        }
    end,
    config = function(_, opts)
        local cmp = require('cmp')
        -- for i, source in ipairs(opts.sources) do
        --     source.group_index = source.group_index or i
        -- end
        cmp.setup(opts)
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                {
                    name = 'buffer',
                    option = { keyword_pattern = [=[[^[:blank:]].*]=] },
                },
            },
        })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'cmdline', priority = 100 },
                { name = 'path', priority = 50 },
                { name = 'cmdline_history', priority = 0 },
            }),
        })
    end,
}
