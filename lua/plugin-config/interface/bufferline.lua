local uConfig = require('uConfig')
local keys = uConfig.keys.bufferLine

local bufferline = requirePlugin('bufferline')
if bufferline == nil then
    return
end

-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
    options = {
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                highlight = 'Directory',
                text_align = 'left',
            },
        },
        -- LSP連携
        diagnostics = 'nvim_lsp',
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
keymap('n', keys.next, ':BufferLineCycleNext<CR>')
keymap('n', keys.prev, ':BufferLineCyclePrev<CR>')

keymap('n', keys.pick, ':BufferLinePick<CR>')
keymap('n', keys.pick_close, ':BufferLinePickClose<CR>')
