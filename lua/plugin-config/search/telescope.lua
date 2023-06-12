-- TODO:
local snippets_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/vim-snippets/UltiSnips/'
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
        layout_config = {
            horizontal = { width = 0.8 },
            -- other layout configuration here
        },
        mappings = {
            i = {
                [keys.move_selection_next] = 'move_selection_next',
                [keys.move_selection_previous] = 'move_selection_previous',
                [keys.cycle_history_next] = 'cycle_history_next',
                [keys.cycle_history_prev] = 'cycle_history_prev',
                [keys.close] = 'close',
                [keys.preview_scrolling_up] = 'preview_scrolling_up',
                [keys.preview_scrolling_down] = 'preview_scrolling_down',
                [keys.open] = 'select_default',
                [keys.open_horizontal] = 'select_horizontal',
                [keys.open_vertical] = 'select_vertical',
            },
        },
    },
    pickers = {
        find_files = {
            theme = 'dropdown',
        },
        live_grep = {
            theme = 'dropdown',
        },
    },
    extensions = {
        packer = {
            theme = 'dropdown',
            layout_config = {
                height = 0.5,
            },
        },
        command_palette = {
            {
                'Open',
                { 'Projects', ':Telescope projects' },
                { 'Recent Files', 'Telescope recent_files pick' },
                { 'Sessions', 'Telescope session-lens search_session' },
            },
            {
                'Vim',
                { 'reload vimrc', ':source $MYVIMRC' },
                { 'check health', ':checkhealth' },
                { 'jumps (Alt-j)', ":lua require('telescope.builtin').jumplist()" },
                { 'command history', ":lua require('telescope.builtin').command_history()" },
                { 'registers (A-e)', ":lua require('telescope.builtin').registers()" },
                { 'colorshceme', ":lua require('telescope.builtin').colorscheme()", 1 },
                { 'search history (C-h)', ":lua require('telescope.builtin').search_history()" },
                { 'spell checker', ':set spell!' },
            },
            {
                'Edit Snipets',
                { 'Python Snipets', 'vsp ' .. snippets_path .. 'python.snippets' },
            },
        },
        xray23 = {
            sessionDir = vim.fn.stdpath('data') .. 'sessions',
        },
    },
})

telescope.load_extension('env')
telescope.load_extension('projects')
telescope.load_extension('command_palette')
telescope.load_extension('recent_files')
telescope.load_extension('session-lens')

-- ファイル検索
keymap('n', keys.find_files, ':Telescope find_files<CR>')
-- グローバル検索
keymap('n', keys.live_grep, ':Telescope live_grep<CR>')
-- コマンドパレット
keymap('n', keys.command_palette, ':Telescope command_palette<CR>')
