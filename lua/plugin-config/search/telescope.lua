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
                'File',
                { 'entire selection (C-a)', ':call feedkeys("GVgg")' },
                { 'save current file (C-s)', ':w' },
                { 'save all files (C-A-s)', ':wa' },
                { 'quit (C-q)', ':qa' },
                { 'file browser (C-i)', ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
                { 'search word (A-w)', ":lua require('telescope.builtin').live_grep()", 1 },
                { 'git files (A-f)', ":lua require('telescope.builtin').git_files()", 1 },
                { 'files (C-f)', ":lua require('telescope.builtin').find_files()", 1 },
            },
            {
                'Help',
                { 'tips', ':help tips' },
                { 'cheatsheet', ':help index' },
                { 'tutorial', ':help tutor' },
                { 'summary', ':help summary' },
                { 'quick reference', ':help quickref' },
                { 'search help(F1)', ":lua require('telescope.builtin').help_tags()", 1 },
            },
            {
                'Vim',
                { 'reload vimrc', ':source $MYVIMRC' },
                { 'check health', ':checkhealth' },
                { 'jumps (Alt-j)', ":lua require('telescope.builtin').jumplist()" },
                { 'commands', ":lua require('telescope.builtin').commands()" },
                { 'command history', ":lua require('telescope.builtin').command_history()" },
                { 'registers (A-e)', ":lua require('telescope.builtin').registers()" },
                { 'colorshceme', ":lua require('telescope.builtin').colorscheme()", 1 },
                { 'vim options', ":lua require('telescope.builtin').vim_options()" },
                { 'keymaps', ":lua require('telescope.builtin').keymaps()" },
                { 'buffers', ':Telescope buffers' },
                { 'search history (C-h)', ":lua require('telescope.builtin').search_history()" },
                { 'paste mode', ':set paste!' },
                { 'cursor line', ':set cursorline!' },
                { 'cursor column', ':set cursorcolumn!' },
                { 'spell checker', ':set spell!' },
                { 'relative number', ':set relativenumber!' },
                { 'search highlighting (F12)', ':set hlsearch!' },
            },
        },
    },
})

telescope.load_extension('env')
telescope.load_extension('projects')
telescope.load_extension('command_palette')

-- ファイル検索
keymap('n', keys.find_files, ':Telescope find_files<CR>')
-- グローバル検索
keymap('n', keys.live_grep, ':Telescope live_grep<CR>')
