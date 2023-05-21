local uConfig = require('uConfig')
local uBufferLine = uConfig.bufferLine

if uBufferLine == nil or not uBufferLine.enable then
    return
end

local bufferline = requirePlugin('bufferline')
if bufferline == nil then
    return
end

-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
    options = {
        close_command = 'Bdelete! %d',
        right_mouse_command = 'Bdelete! %d',
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
                local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or '')
                s = s .. n .. sym
            end
            return s
        end,
    },
})

------------ bufferline
keymap('n', uBufferLine.prev, ':BufferLineCyclePrev<CR>')
keymap('n', uBufferLine.next, ':BufferLineCycleNext<CR>')

keymap('n', uBufferLine.close, ':Bdelete!<CR>') --"moll/vim-bbye"
keymap('n', uBufferLine.close_others, ':BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>')
keymap('n', uBufferLine.close_pick, ':BufferLinePickClose<CR>')
