local utils = require('utils')
local keymaps = require('keymaps')

local have_make = vim.fn.executable('make') == 1
local have_cmake = vim.fn.executable('cmake') == 1

return {
    {
        dependencies = {
        },
        keys = function()
            local builtin = require('telescope.builtin')
            return {
                {
                    keymaps.telescope.commands,
                    '<CMD>Telescope commands<CR>',
                    desc = 'Commands',
                },
                {
                    keymaps.telescope.commands_history,
                    '<CMD>Telescope command_history<CR>',
                    desc = 'Command History',
                },
                -- git
                { keymaps.telescope.git_commits, '<CMD>Telescope git_commits<CR>', desc = 'Git commits' },
                { keymaps.telescope.git_status, '<CMD>Telescope git_status<CR>', desc = 'Git status' },
                -- search
                { keymaps.telescope.registers, '<CMD>Telescope registers<CR>', desc = 'Registers' },
                { keymaps.telescope.autocmd, '<CMD>Telescope autocommands<CR>', desc = 'Auto Commands' },
                {
                    keymaps.telescope.doc_diagnostics,
                    '<CMD>Telescope diagnostics bufnr=0<CR>',
                    desc = 'Document diagnostics',
                },
                {
                    keymaps.telescope.workspace_diagnostics,
                    '<CMD>Telescope diagnostics<CR>',
                    desc = 'Workspace diagnostics',
                },
                { keymaps.telescope.highlights, '<CMD>Telescope highlights<CR>', desc = 'Search Highlight Groups' },
                { keymaps.telescope.keymaps, '<CMD>Telescope keymaps<CR>', desc = 'Key Maps' },
                { keymaps.telescope.marks, '<CMD>Telescope marks<CR>', desc = 'Jump to Mark' },
                { keymaps.telescope.options, '<CMD>Telescope vim_options<CR>', desc = 'Options' },
                {
                    keymaps.telescope.colorscheme,
                    builtin.colorscheme({ enable_preview = true }),
                    desc = 'Colorscheme preview',
                },
            }
        end,
        opts = function()
            local actions = require('telescope.actions')
            return {
                defaults = {

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
                            [keymaps.telescope.select_tab] = actions.select_tab,
                            [keymaps.telescope.move_selection_next] = actions.move_selection_next,
                            [keymaps.telescope.move_selection_previous] = actions.move_selection_previous,
                            [keymaps.telescope.cycle_history_next] = actions.cycle_history_next,
                            [keymaps.telescope.cycle_history_prev] = actions.cycle_history_prev,
                            [keymaps.telescope.select_vertical] = actions.select_vertical,
                            [keymaps.telescope.select_horizontal] = actions.select_horizontal,
                            [keymaps.floatWindow.scrollLeft] = actions.preview_scrolling_left,
                            [keymaps.floatWindow.scrollRight] = actions.preview_scrolling_right,
                            [keymaps.floatWindow.scrollDown] = actions.preview_scrolling_down,
                            [keymaps.floatWindow.scrollUp] = actions.preview_scrolling_up,
                        },
                        n = {
                            [keymaps.telescope.close] = actions.close,
                        },
                    },
                },
            }
        end,
    },
}
