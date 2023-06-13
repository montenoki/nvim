local status, lspkind = pcall(require, 'lspkind')
if not status then
    return
end

lspkind.init({
    -- default: true
    -- with_text = true,
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',
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
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
    },
})

local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol_text',
        -- mode = 'symbol', -- show only symbol annotations

        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(entry, vim_item)
            -- Source 显示提示来源
            vim_item.menu = '[' .. string.upper(entry.source.name) .. ']'
            return vim_item
        end,
    }),
}

return M
