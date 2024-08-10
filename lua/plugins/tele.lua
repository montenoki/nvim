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
            }
        end,
        opts = function()
            local actions = require('telescope.actions')
            return {
                defaults = {
                    prompt_prefix = ' ',
                    selection_caret = ' ',
                    mappings = {
                        i = {},
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
}
