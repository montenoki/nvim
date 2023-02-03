local uConfig = require('uConfig')
local uTelescope = uConfig.telescope

if uTelescope == nil or not uTelescope.enable then
    return
end

local telescope = requirePlugin('telescope')
if telescope == nil then
    return
end

local actions = require('telescope.actions')
local trouble = require('trouble.providers.telescope')

telescope.setup({
    defaults = {
        initial_mode = 'insert',
        -- vertical, center, cursor
        layout_strategy = 'horizontal',
        mappings = {
            i = {
                [uTelescope.move_selection_next] = 'move_selection_next',
                [uTelescope.move_selection_previous] = 'move_selection_previous',
                [uTelescope.cycle_history_next] = 'cycle_history_next',
                [uTelescope.cycle_history_prev] = 'cycle_history_prev',
                [uTelescope.close] = 'close',
                [uTelescope.preview_scrolling_up] = 'preview_scrolling_up',
                [uTelescope.preview_scrolling_down] = 'preview_scrolling_down',
                ['<c-t>'] = trouble.open_with_trouble,
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

-- ファイル検索
keymap('n', uTelescope.find_files, ':Telescope find_files<CR>')
-- グローバル検索
keymap('n', uTelescope.live_grep, ':Telescope live_grep<CR>')

pcall(telescope.load_extension, 'env')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'projects')
