-- TODO:
local uConfig = require('uConfig')
local keys = uConfig.keys.telescope

local telescope = requirePlugin('telescope')
if telescope == nil then
    return
end

telescope.setup({
    defaults = {
        initial_mode = 'insert',
        -- vertical, center, cursor
        layout_strategy = 'horizontal',
        mappings = {
            i = {
                [keys.move_selection_next] = 'move_selection_next',
                [keys.move_selection_previous] = 'move_selection_previous',
                [keys.cycle_history_next] = 'cycle_history_next',
                [keys.cycle_history_prev] = 'cycle_history_prev',
                [keys.close] = 'close',
                [keys.preview_scrolling_up] = 'preview_scrolling_up',
                [keys.preview_scrolling_down] = 'preview_scrolling_down',
                [keys.open_horizontal] = 'select_horizontal',
                [keys.open_vertical] = 'select_vertical',
            },
        },
    },
    pickers = {
        find_files = {},
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown({
                --    initial_mode = 'normal',
            }),
        },
    },
})

telescope.load_extension('env')
telescope.load_extension('ui-select')
-- telescope.load_extension('projects')

-- ファイル検索
keymap('n', keys.find_files, ':Telescope find_files<CR>')
-- グローバル検索
keymap('n', keys.live_grep, ':Telescope live_grep<CR>')
