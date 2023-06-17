local cmp = requirePlugin('cmp')
local uConfig = require('uConfig')
local keys = uConfig.keys.cmp

if cmp == nil then
    return
end

local formatter
if uConfig.enable.lite_mode then
    formatter = nil
else
    formatter = require('cmp.lspkind').formatting
end

local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
local mapping = {
    [keys.show] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    [keys.abort] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),

    [keys.confirm] = cmp.mapping.confirm({
        select = false,
        behavior = cmp.ConfirmBehavior.Insert,
    }),
    [keys.scroll_doc_up] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    [keys.scroll_doc_down] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

    [keys.select_next_item] = function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end,
    [keys.select_prev_item] = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end,

    [keys.jump_forwards] = cmp.mapping(function(fallback)
        cmp_ultisnips_mappings.jump_forwards(fallback)
    end, { 'i', 's', 'c' }),
    [keys.jump_backwards] = cmp.mapping(function(fallback)
        cmp_ultisnips_mappings.jump_backwards(fallback)
    end, { 'i', 's', 'c' }),
}

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = mapping,
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'vim-snippets' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = 'path' },
    }, {
        { name = 'emoji' },
    }),
    formatting = formatter,
})

cmp.setup.cmdline({ '/', '?', '/\v' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }, { { name = 'cmdline_history' } }),
})

