local uConfig = require('uConfig')
local keys = uConfig.keys.bufferLine

local bufferline = requirePlugin('bufferline')
if bufferline == nil or not uConfig.enable.bufferline then
    return
end

local buffer_close_icon
local modified_icon
local close_icon
local left_trunc_marker
local right_trunc_marker
local show_buffer_icons

if uConfig.enable.lite_mode then
    buffer_close_icon = 'x'
    modified_icon = 'o'
    close_icon = 'x'
    left_trunc_marker = '<-'
    right_trunc_marker = '->'
    show_buffer_icons = false
else
    buffer_close_icon = '󰅖'
    modified_icon = '●'
    close_icon = ''
    left_trunc_marker = ''
    right_trunc_marker = ''
    show_buffer_icons = true
end

bufferline.setup({
    options = {
        mode = 'tabs',
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',

        buffer_close_icon = buffer_close_icon,
        modified_icon = modified_icon,
        close_icon = close_icon,
        left_trunc_marker = left_trunc_marker,
        right_trunc_marker = right_trunc_marker,

        show_buffer_icons = show_buffer_icons,
        indicator = {
            icon = '|:', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },

        offsets = {
            -- to findout filetype
            -- run ``lua print(vim.bo.filetype)``
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                highlight = 'Directory',
                text_align = 'left',
            },
            {
                filetype = 'dapui_scopes',
                text = 'Debug Mode',
                highlight = 'Directory',
                text_align = 'left',
            },
            {
                filetype = 'Outline',
                text = 'Outline',
                highlight = 'Directory',
                text_align = 'left',
            },
        },
        -- LSP連携
        diagnostics = 'nvim_lsp', -- | 'coc',
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = ' '
            for e, n in pairs(diagnostics_dict) do
                if uConfig.enable.lite_mode then
                    local sym = e == 'error' and 'e ' or (e == 'warning' and 'w ' or 'i')
                    s = s .. n .. sym
                else
                    local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or '')
                    s = s .. n .. sym
                end
            end
            return s
        end,
    },
})

------------ bufferline
keymap('n', keys.next, '<CMD>BufferLineCycleNext<CR>')
keymap('n', keys.prev, '<CMD>BufferLineCyclePrev<CR>')

keymap('n', keys.pick, '<CMD>BufferLinePick<CR>')
keymap('n', keys.pick_close, '<CMD>BufferLinePickClose<CR>')
