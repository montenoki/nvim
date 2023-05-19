-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
-- https://github.com/hrsh7th/nvim-cmp
-- https://github.com/onsails/lspkind-nvim
local cmp = requirePlugin('cmp')
if cmp == nil then
    return
end

local uConfig = require('uConfig')
local formatter
if uConfig.lite_mode then
    formatter = nil
else
    formatter = require('cmp.lspkind').formatting
end

local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
local mapping = {
    [uConfig.keys.cmp_complete] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    [uConfig.keys.cmp_abort] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
    [uConfig.keys.cmp_confirm] = cmp.mapping.confirm({
        select = false,
        behavior = cmp.ConfirmBehavior.Replace,
    }),
    [uConfig.keys.cmp_scroll_doc_up] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    [uConfig.keys.cmp_scroll_doc_down] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

    [uConfig.keys.cmp_select_next_item] = cmp.mapping(function(fallback)
        cmp_ultisnips_mappings.compose({ 'select_next_item', 'jump_forwards' })(fallback)
    end, { 'i', 's', 'c' }),
    [uConfig.keys.cmp_select_prev_item] = cmp.mapping(function(fallback)
        cmp_ultisnips_mappings.compose({ 'select_prev_item', 'jump_backwards' })(fallback)
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
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp', group_index = 1 },
            { name = 'ultisnips', group_index = 1 },
            { name = 'vim-snippets', group_index = 1 },
            { name = 'nvim_lsp_signature_help', group_index = 1 }
        },
        {
            { name = 'buffer', group_index = 2 },
            { name = 'path', group_index = 2 }
        },
        {
            {name = 'emoji', group_index = 3 }
        }
    ),
    formatting = formatter,
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { {
        name = 'buffer',
    } },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {{name = 'path'}},
        {{ name = 'cmdline'}},
        {{ name = 'cmdline_history'}},

    )
})

-- TODO:
-- cmp.setup.filetype({ 'markdown', 'help' }, {
--     sources = {
--         {
--             name = 'luasnip',
--         },
--         {
--             name = 'buffer',
--         },
--         {
--             name = 'path',
--         },
--     },
-- })

