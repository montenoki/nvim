return {
    'hrsh7th/nvim-cmp',
    version = false, -- last release is way too old
    event = { 'CmdlineEnter' },
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
    },
    opts = function()
        vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
        local cmp = require('cmp')
        return {
            preselect = cmp.PreselectMode.None,
        }
    end,
    config = function(_, opts)
        local cmp = require('cmp')
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                {
                    name = 'cmdline',
                    priority = 100,

                    entry_filter = function(entry, _)
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
                    end,
                },
            }),
        })
    end,
}
