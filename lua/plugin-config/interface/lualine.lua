local lualine = requirePlugin('lualine')
if lualine == nil then
    return
end
local uConfig = require('uConfig')
local symbols
local separators

if uConfig.lite_mode then
    symbols = {
        unix = 'LF', -- e712
        dos = 'CRLF', -- e70f
        mac = 'CR', -- e711
    }
    separators = { left = '#-', right = '-#' }
else
    symbols = {
        unix = 'LF', -- e712
        dos = 'CRLF', -- e70f
        mac = 'CR', -- e711
    }
    separators = { left = ' ', right = '' } 
end


lualine.setup({
    options = {
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        section_separators = separators,
    },
    extensions = { 'nvim-tree', 'toggleterm', 'nvim-dap-ui' },
    sections = {
        lualine_c = { 'filename' },
        lualine_x = {
            'filesize',
            {
                'fileformat',
                symbols = symbols,
            },
            'encoding',
            'filetype',
        },
    },
})
