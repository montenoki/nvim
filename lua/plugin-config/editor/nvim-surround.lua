local surround = requirePlugin('nvim-surround')
local uConfig = require('uConfig')

if surround == nil or not uConfig.enable.surround then
    return
end

surround.setup({
    keymaps = {
        -- you surround
        normal = 'ys',
        -- you surround with delimiter
        normal_line = 'yS',
        -- you surround line
        normal_cur = 'yss',
        -- you surround line with delimiter
        normal_cur_line = 'ySS',

        delete = 'ds',
        change = 'cs',

        insert = '<C-g>s',
        insert_line = '<C-g>S',

        visual = 's',
        visual_line = 'gs',
    },
})
