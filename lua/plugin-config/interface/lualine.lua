local uConfig = require('uConfig')
local lualine = requirePlugin('lualine')
if lualine == nil or not uConfig.enable.lualine then
    return
end

local symbols
local separators

if uConfig.enable.lite_mode then
    symbols = {
        unix = 'LF', -- e712
        dos = 'CRLF', -- e70f
        mac = 'CR', -- e711
    }
    separators = { left = '', right = '' }
else
    symbols = {
        unix = '', -- e712
        dos = '', -- e70f
        mac = '', -- e711
    }
    separators = { left = '', right = '' }
end

lualine.setup({
    options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = separators,
    },
    extensions = { 'nvim-tree', 'toggleterm', 'nvim-dap-ui' },
    sections = {
        lualine_c = { 'filename', { require('auto-session.lib').current_session_name } },
        lualine_x = {
            {
                'fileformat',
                symbols = symbols,
            },
            'encoding',
            'filetype',
        },
        lualine_y = {},
    },
})
