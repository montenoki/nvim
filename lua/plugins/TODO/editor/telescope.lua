local Lazyvim = require('lazyvim')
local utils = require('utils')
local Keys = require('keymaps').telescope
return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        version = false, -- telescope did only one release, so use HEAD for now
        init = function()
            require('which-key').add({
                { '<leader>s', group = '+search', mode = { 'n', 'v' } },
            })
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'LinArcX/telescope-env.nvim',
            'LinArcX/telescope-command-palette.nvim',
            'smartpde/telescope-recent-files',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                enabled = vim.fn.executable('make') == 1,
                config = function()
                    local telescope = require('telescope')
                    utils.on_load('telescope.nvim', function()
                        telescope.load_extension('fzf')
                        telescope.load_extension('env')
                        telescope.load_extension('command_palette')
                        telescope.load_extension('recent_files')
                    end)
                end,
            },
        },
        keys = {
            {
                Keys.switch_buffer,
                '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>',
                desc = 'Switch Buffer',
            },
            {
                Keys.grep,
                Lazyvim.telescope('live_grep'),
                desc = 'Grep',
            },
            {
                Keys.find,
                Lazyvim.telescope('find_files'),
                desc = 'Find Files',
            },
            {
                Keys.commands,
                '<CMD>Telescope commands<CR>',
                desc = 'Commands',
            },
            {
                Keys.commands_history,
                '<CMD>Telescope command_history<CR>',
                desc = 'Command History',
            },
            -- git
            { Keys.git_commits, '<CMD>Telescope git_commits<CR>', desc = 'Git commits' },
            { Keys.git_status, '<CMD>Telescope git_status<CR>', desc = 'Git status' },
            -- search
            { Keys.registers, '<CMD>Telescope registers<CR>', desc = 'Registers' },
            { Keys.autocmd, '<CMD>Telescope autocommands<CR>', desc = 'Auto Commands' },
            { Keys.doc_diagnostics, '<CMD>Telescope diagnostics bufnr=0<CR>', desc = 'Document diagnostics' },
            { Keys.workspace_diagnostics, '<CMD>Telescope diagnostics<CR>', desc = 'Workspace diagnostics' },
            { Keys.highlights, '<CMD>Telescope highlights<CR>', desc = 'Search Highlight Groups' },
            { Keys.keymaps, '<CMD>Telescope keymaps<CR>', desc = 'Key Maps' },
            { Keys.marks, '<CMD>Telescope marks<CR>', desc = 'Jump to Mark' },
            { Keys.options, '<CMD>Telescope vim_options<CR>', desc = 'Options' },
            {
                Keys.colorscheme,
                Lazyvim.telescope('colorscheme', { enable_preview = true }),
                desc = 'Colorscheme preview',
            },
        },
        opts = function()
            local actions = require('telescope.actions')
            return {
                defaults = {
                    prompt_prefix = vim.g.lite == nil and ' ' or '>',
                    selection_caret = vim.g.lite == nil and ' ' or '>',
                    -- open files in the first window that is an actual file.
                    -- use the current window if no other window is available.
                    get_selection_window = function()
                        local wins = vim.api.nvim_list_wins()
                        table.insert(wins, 1, vim.api.nvim_get_current_win())
                        for _, win in ipairs(wins) do
                            local buf = vim.api.nvim_win_get_buf(win)
                            if vim.bo[buf].buftype == '' then
                                return win
                            end
                        end
                        return 0
                    end,
                    mappings = {
                        i = {
                            [Keys.select_tab] = actions.select_tab,
                            [Keys.move_selection_next] = actions.move_selection_next,
                            [Keys.move_selection_previous] = actions.move_selection_previous,
                            [Keys.cycle_history_next] = actions.cycle_history_next,
                            [Keys.cycle_history_prev] = actions.cycle_history_prev,
                            [Keys.select_vertical] = actions.select_vertical,
                            [Keys.select_horizontal] = actions.select_horizontal,
                            [Keys.scroll_left] = actions.preview_scrolling_left,
                            [Keys.scroll_right] = actions.preview_scrolling_right,
                            [Keys.scroll_down] = actions.preview_scrolling_down,
                            [Keys.scroll_up] = actions.preview_scrolling_up,
                        },
                        n = {
                            [Keys.close] = actions.close,
                        },
                    },
                },
            }
        end,
    },
}
