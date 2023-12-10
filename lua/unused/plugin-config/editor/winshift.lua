local winshift = requirePlugin('winshift')
local uConfig = require('uConfig')

if winshift == nil or not uConfig.enable.winshift then
    return
end

winshift.setup({
    highlight_moving_win = true, -- Highlight the window being moved
    focused_hl_group = 'Visual', -- The highlight group used for the moving window
    moving_win_options = {
        -- These are local options applied to the moving window while it's
        -- being moved. They are unset when you leave Win-Move mode.
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = '',
    },
    keymaps = {
        disable_defaults = true, -- Disable the default keymaps
        win_move_mode = {
            ['h'] = 'left',
            ['j'] = 'down',
            ['k'] = 'up',
            ['l'] = 'right',
            ['H'] = 'far_left',
            ['J'] = 'far_down',
            ['K'] = 'far_up',
            ['L'] = 'far_right',
            ['<left>'] = 'left',
            ['<down>'] = 'down',
            ['<up>'] = 'up',
            ['<right>'] = 'right',
            ['<S-left>'] = 'far_left',
            ['<S-down>'] = 'far_down',
            ['<S-up>'] = 'far_up',
            ['<S-right>'] = 'far_right',
        },
    },
})
keymap('n', 'sm',  '<CMD>WinShift<CR>')
