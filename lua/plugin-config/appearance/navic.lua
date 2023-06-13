local uConfig = require('uConfig')
local navic = requirePlugin('nvim-navic')
if navic == nil then
    return
end

local icons
if uConfig.enable.lite_mode then
    icons = {
        File = '',
        Module = '',
        Namespace = '',
        Package = '',
        Class = '',
        Method = '',
        Property = '',
        Field = '',
        Constructor = '',
        Enum = '',
        Interface = '',
        Function = '',
        Variable = '',
        Constant = '',
        String = '',
        Number = '',
        Boolean = '',
        Array = '',
        Object = '',
        Key = '',
        Null = '',
        EnumMember = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
    }
else
    icons = {
        File = '󰈙 ',
        Module = ' ',
        Namespace = '󰌗 ',
        Package = ' ',
        Class = '󰌗 ',
        Method = '󰆧 ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = '󰕘',
        Interface = '󰕘',
        Function = '󰊕 ',
        Variable = '󰆧 ',
        Constant = '󰏿 ',
        String = '󰀬 ',
        Number = '󰎠 ',
        Boolean = '◩ ',
        Array = '󰅪 ',
        Object = '󰅩 ',
        Key = '󰌋 ',
        Null = '󰟢 ',
        EnumMember = ' ',
        Struct = '󰌗 ',
        Event = ' ',
        Operator = '󰆕 ',
        TypeParameter = '󰊄 ',
    }
end
navic.setup({
    icons = icons,
    lsp = {
        auto_attach = true,
        preference = nil,
    },
    highlight = true,
    separator = ' > ',
    depth_limit = 0,
    depth_limit_indicator = '..',
    safe_output = true,
    click = false,
})

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
