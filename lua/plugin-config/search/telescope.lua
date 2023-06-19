local uConfig = require('uConfig')
local telescope = requirePlugin('telescope')
if telescope == nil or not uConfig.enable.telescope then
    return
end

local keys = uConfig.keys.telescope

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
                'JumpTo',
                { 'TODO list', ':TodoTelescope' },
                { 'Buffers', 'Telescope buffers' },
                { 'Marks', 'Telescope marks' },
            },
            {
                'History',
                { 'Jumplist', 'Telescope jumplist' },
                { 'Command History', 'Telescope command_history' },
                { 'Search History', 'Telescope search_history' },
            },
            {
                'Vim',
                { 'Check Health', ':checkhealth' },
                { 'reload vimrc', ':source $MYVIMRC' },
                { 'Registers', 'Telescope registers' },
                { 'Colorscheme', 'Telescope colorscheme' },
                { 'spell checer', ':set spell!' },
            },
            {
                'Checker',
                { 'Check ENV', 'Telescope env' },
                { 'Highlights', 'Telescope highlights' },
                { 'Keymaps', 'Telescope keymaps' },
                { 'Symbols', 'Telescope symbols' },
                { 'LSP Info', 'LspInfo' },
                { 'Null-ls Info', 'NullLsInfo' },
            },
            {
                'Edit Snippets',
                { 'Python', 'UltiSnipsEdit python' },
                { 'Lua', 'UltiSnipsEdit lua' },
            },
            {
                'File Encoding',
                { 'Check File Encoding', ':lua vim.notify(vim.opt.fileencoding:get(), "info", {title = "File Encoding"})' },
                { 'Check Vim  Encoding', ':lua vim.notify(vim.opt.encoding:get(), "info", {title = "NeoVim Encoding"})' },
                { 'Save   in UTF-8', ':set fileencoding=utf-8' },
                { 'Reload in UTF-8', ':edit ++encoding=utf-8' },
                { 'Save   in Shift-JIS', ':set fileencoding=sjis' },
                { 'Reload in Shift-JIS', ':edit ++encoding=sjis' },
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

keymap('n', keys.find_files, '<CMD>Telescope find_files<CR>')
keymap('n', keys.live_grep, '<CMD>Telescope live_grep<CR>')
keymap('n', keys.command_palette, '<CMD>Telescope command_palette<CR>')
keymap('n', keys.spell_suggest, '<CMD>Telescope spell_suggest<CR>')
