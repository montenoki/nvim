local lualine = requirePlugin('lualine')
if lualine == nil then
    return
end

lualine.setup({
    options = {
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        section_separators = { left = ' ', right = '' },
    },
    extensions = { 'nvim-tree', 'toggleterm', 'nvim-dap-ui' },
    sections = {
        lualine_c = { 'filename' },
        lualine_x = {
            'filesize',
            {
                'fileformat',
                symbols = {
                    unix = 'LF', -- e712
                    dos = 'CRLF', -- e70f
                    mac = 'CR', -- e711
                },
            },
            'encoding',
            'filetype',
        },
    },
})
