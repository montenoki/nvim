local uConfig = require('uConfig')
local lspkind = requirePlugin('lspkind')

if lspkind == nil then
    return
end
local mode
if uConfig.enable.lite_mode then
    mode = 'text'
else
    mode = 'symbol_text'
end

lspkind.init({
    mode = mode,
    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',
    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = '󰊄',
        Method = 'ƒ',
        Function = '󰊕',
        Constructor = '',
        Field = '󰽐',
        Variable = '󰫧',
        Class = '𝓒',
        Interface = '',
        Module = '󰆧',
        Property = '',
        Unit = '󰚯',
        Value = '󰫧',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
    },
})

local M = {}
M.formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol_text',
        maxwidth = 50,
        before = function(entry, vim_item)
            vim_item.menu = '[' .. string.upper(entry.source.name) .. ']'
            return vim_item
        end,
    }),
}
return M
