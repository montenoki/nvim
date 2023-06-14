local uConfig = require('uConfig')
local keys = uConfig.keys.symbols_outline
local symbolsOutline = requirePlugin('symbols-outline')
if symbolsOutline == nil or not uConfig.enable.symbols_outline then
    return
end

local symbols
local fold_markers

if uConfig.enable.lite_mode then
    symbols = {
        File = { icon = '', hl = '@text.uri' },
        Module = { icon = '', hl = '@namespace' },
        Namespace = { icon = '', hl = '@namespace' },
        Package = { icon = '', hl = '@namespace' },
        Class = { icon = '', hl = '@type' },
        Method = { icon = '', hl = '@method' },
        Property = { icon = '', hl = '@method' },
        Field = { icon = '', hl = '@field' },
        Constructor = { icon = '', hl = '@constructor' },
        Enum = { icon = '', hl = '@type' },
        Interface = { icon = '', hl = '@type' },
        Function = { icon = '', hl = '@function' },
        Variable = { icon = '', hl = '@constant' },
        Constant = { icon = '', hl = '@constant' },
        String = { icon = '', hl = '@string' },
        Number = { icon = '', hl = '@number' },
        Boolean = { icon = '', hl = '@boolean' },
        Array = { icon = '', hl = '@constant' },
        Object = { icon = '', hl = '@type' },
        Key = { icon = '', hl = '@type' },
        Null = { icon = '', hl = '@type' },
        EnumMember = { icon = '', hl = '@field' },
        Struct = { icon = '', hl = '@type' },
        Event = { icon = '', hl = '@type' },
        Operator = { icon = '', hl = '@operator' },
        TypeParameter = { icon = '', hl = '@parameter' },
        Component = { icon = '', hl = '@function' },
        Fragment = { icon = '', hl = '@constant' },
    }
    fold_markers = { '+', '-' }
else
    symbols = {
        File = { icon = '', hl = '@text.uri' },
        Module = { icon = '󰆧', hl = '@namespace' },
        Namespace = { icon = '', hl = '@namespace' },
        Package = { icon = '󰏗', hl = '@namespace' },
        Class = { icon = '𝓒', hl = '@type' },
        Method = { icon = 'ƒ', hl = '@method' },
        Property = { icon = '', hl = '@method' },
        Field = { icon = '󰽐', hl = '@field' },
        Constructor = { icon = '', hl = '@constructor' },
        Enum = { icon = '', hl = '@type' },
        Interface = { icon = '', hl = '@type' },
        Function = { icon = '󰊕', hl = '@function' },
        Variable = { icon = '󰫧', hl = '@constant' },
        Constant = { icon = '󰏿', hl = '@constant' },
        String = { icon = '𝓐', hl = '@string' },
        Number = { icon = '', hl = '@number' },
        Boolean = { icon = '◩', hl = '@boolean' },
        Array = { icon = '', hl = '@constant' },
        Object = { icon = '⦿', hl = '@type' },
        Key = { icon = '', hl = '@type' },
        Null = { icon = '󰟢', hl = '@type' },
        EnumMember = { icon = '', hl = '@field' },
        Struct = { icon = '', hl = '@type' },
        Event = { icon = '', hl = '@type' },
        Operator = { icon = '', hl = '@operator' },
        TypeParameter = { icon = '', hl = '@parameter' },
        Component = { icon = '󰡀', hl = '@function' },
        Fragment = { icon = '', hl = '@constant' },
    }
    fold_markers = { '', '' }
end

symbolsOutline.setup({
    highlight_hovered_item = true,
    show_guides = false,
    auto_preview = false,
    position = 'left',
    relative_width = false,
    width = 40,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    autofold_depth = 1,
    auto_unfold_hover = true,
    fold_markers = fold_markers,
    wrap = false,
    keymaps = {
        -- These keymaps can be a string or a table for multiple keys
        close = keys.close,
        goto_location = keys.goto_location,
        focus_location = keys.focus_location,
        hover_symbol = keys.hover_symbol,
        toggle_preview = '',
        rename_symbol = keys.rename_symbol,
        code_actions = keys.code_actions,
        fold = keys.fold,
        unfold = keys.unfold,
        fold_all = keys.fold_all,
        unfold_all = keys.unfold_all,
        fold_reset = keys.fold_reset,
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = symbols,
})

keymap({ 'n', 'i' }, uConfig.keys.symbols_outline.toggle, '<CMD>SymbolsOutline<CR>')
