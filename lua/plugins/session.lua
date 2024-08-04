local keymaps = require('keymaps')
local utils = require('utils')
return {
    {
        'rmagatti/auto-session',

        lazy = false,
        keys = {
            { keymaps.session.save, '<CMD>SessionSave<CR>', desc = 'Session Save' },
            { keymaps.session.restore, '<CMD>SessionRestore<CR>', desc = 'Session Restore' },
            { keymaps.session.del, '<CMD>SessionDelete<CR>', desc = 'Session Delete' },
            { keymaps.session.show_all, '<CMD>SessionSearch<CR>', desc = 'Show All Session' },
        },
        init = function()
            require('which-key').add({
                { 'gs', group = '+Surround', mode = { 'n', 'v' } },
            })
        end,
        opts = {
            log_level = vim.log.levels.ERROR,
            auto_session_suppress_dirs = {
                '~/',
                '~/Projects',
                '~/Downloads',
                '/',
                '~/codes',
            },
            auto_session_create_enabled = true,
            auto_session_use_git_branch = true,
            {
                -- ⚠️ This will only work if Telescope.nvim is installed
                -- The following are already the default values, no need to provide them if these are already the settings you want.
                session_lens = {
                    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                    buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                    load_on_setup = true,
                    theme_conf = { border = true },
                    previewer = false,
                },
            },
        },
    },
    {
        'lualine.nvim',
        -- dependencies = { 'nvim-lualine/lualine.nvim' },
        opts = function(_, opts)
            local lualine_require = require('lualine_require')
            lualine_require.require = require
            local ok, _ = pcall(require('auto-session.lib').current_session_name)
            vim.print(vim.inspect(opts))
            if type(opts.sections.lualine_c) == 'table' then
                table.insert(opts.sections.lualine_c, 2, {
                    function()
                        return ok and ' ON' or ' OFF'
                    end,
                    color = ok and utils.fg('Character') or utils.fg('Comment'),
                    -- TODO:check Telescope exists
                    on_click = function()
                        if package.loaded["plugin_name"] ~= nil then
                            vim.cmd.Telescope('session-lens')
                        else
                            utils.info('Telescope is not installed')
                        end
                    end,
                })
            end
        end,
    },
}
