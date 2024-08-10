local utils = require('utils')
local keymaps = require('keymaps')

local have_make = vim.fn.executable('make') == 1
local have_cmake = vim.fn.executable('cmake') == 1

return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        cmd = 'Telescope',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'LinArcX/telescope-env.nvim',
            'smartpde/telescope-recent-files',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = have_make and 'make'
                    or 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
                enabled = have_make or have_cmake,
                config = function(plugin)
                    local telescope = require('telescope')
                    utils.on_load('telescope.nvim', function()
                        ---@diagnostic disable-next-line: undefined-field
                        local ok, err = pcall(telescope.load_extension, 'fzf')
                        if not ok then
                            local lib = plugin.dir .. '/build/libfzf.' .. (utils.is_win() and 'dll' or 'so')
                            if not vim.uv.fs_stat(lib) then
                                utils.warn('`telescope-fzf-native.nvim` not built. Rebuilding...')
                                require('lazy').build({ plugins = { plugin }, show = false }):wait(function()
                                    utils.info('Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.')
                                end)
                            else
                                utils.error('Failed to load `telescope-fzf-native.nvim`:\n' .. err)
                            end
                        end
                    end)
                end,
            },
        },
        init = function()
            require('which-key').add({
                { '<leader>s', group = '+search', mode = { 'n', 'v' } },
            })
        end,
        keys = function()
            local builtin = require('telescope.builtin')
            return {
                {
                    keymaps.telescope.grep,
                    builtin.live_grep,
                    desc = 'Grep',
                },
                {
                    keymaps.telescope.find,
                    builtin.find_files,
                    desc = 'Find Files',
                },
                {
                    keymaps.telescope.switch_buffer,
                    '<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>',
                    desc = 'Switch Buffer',
                },
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
                {
                    keymaps.telescope.git_commits,
                    '<CMD>Telescope git_commits<CR>',
                    desc = 'Git commits',
                },
                {
                    keymaps.telescope.git_status,
                    '<CMD>Telescope git_status<CR>',
                    desc = 'Git status',
                },
                {
                    keymaps.telescope.registers,
                    '<CMD>Telescope registers<CR>',
                    desc = 'Registers',
                },
                {
                    keymaps.telescope.autocmd,
                    '<CMD>Telescope autocommands<CR>',
                    desc = 'Auto Commands',
                },
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
                {
                    keymaps.telescope.quickfix,
                    '<cmd>Telescope quickfix<cr>',
                    desc = 'Quickfix List',
                },
                {
                    keymaps.telescope.highlights,
                    '<CMD>Telescope highlights<CR>',
                    desc = 'Search Highlight Groups',
                },
                {
                    keymaps.telescope.keymaps,
                    '<CMD>Telescope keymaps<CR>',
                    desc = 'Key Maps',
                },
                {
                    keymaps.telescope.marks,
                    '<CMD>Telescope marks<CR>',
                    desc = 'Jump to Mark',
                },
                {
                    keymaps.telescope.options,
                    '<CMD>Telescope vim_options<CR>',
                    desc = 'Options',
                },
                {
                    keymaps.telescope.colorscheme,
                    -- stylua: ignore
                    function() builtin.colorscheme({ enable_preview = true }) end,
                    desc = 'Colorscheme preview',
                },
            }
        end,
        opts = function()
            local actions = require('telescope.actions')
            return {
                defaults = {
                    prompt_prefix = ' ',
                    selection_caret = ' ',
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
                            -- [keymaps.floatWindow.scrollLeft] = actions.preview_scrolling_left,
                            -- [keymaps.floatWindow.scrollRight] = actions.preview_scrolling_right,
                            [keymaps.floatWindow.scrollDown] = actions.preview_scrolling_down,
                            [keymaps.floatWindow.scrollUp] = actions.preview_scrolling_up,
                        },
                        n = {
                            [keymaps.telescope.close] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = utils.find_command,
                        hidden = true,
                    },
                },
            }
        end,
        config = function(opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            telescope.load_extension('env')
            telescope.load_extension('recent_files')
            telescope.load_extension('fzf')
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function()
            local lspKeymaps = require('plugins.lsp.keymaps').get()
      -- stylua: ignore
      vim.list_extend(lspKeymaps, {
        {keymaps.lsp.definition, function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
        {keymaps.lsp.references, "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true },
        {keymaps.lsp.implementation, function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
        {keymaps.lsp.type_definition, function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      })
        end,
    },
}
