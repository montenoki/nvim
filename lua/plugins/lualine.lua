local utils = require('utils')
local icons = require('config').icons

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
        vim.opt.showmode = false -- Disable the default showmode
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            -- Set an empty statusline till lualine loads
            vim.o.statusline = ' '
        else
            -- hide the statusline on the starter page
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        local lualine_require = require('lualine_require')
        lualine_require.require = require

        vim.o.laststatus = vim.g.lualine_laststatus
        return {
            options = {
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
                disabled_filetypes = { winbar = { 'dap-repl' } },
            },
            extensions = {
                'lazy',
                'mason',
                'nvim-tree',
                'man',
                'toggleterm',
                'nvim-dap-ui',
                'symbols-outline',
                'quickfix',
                'fzf',
                'trouble',
            },
            sections = {
                lualine_a = {
                    { 'mode', icon = '' },
                },
                lualine_b = {
                    { 'branch', icon = '' },
                },
                lualine_c = {
                    {
                        function()
                            local original_bufnr = vim.api.nvim_get_current_buf()
                            local buf_clients = vim.lsp.get_active_clients({ bufnr = original_bufnr })
                            if vim.fn.exists(':LspInfo') == 0 then
                                return ':off'
                            end
                            return ':' .. tostring(#vim.tbl_keys(buf_clients))
                        end,
                        color = function()
                            local original_bufnr = vim.api.nvim_get_current_buf()
                            local buf_clients = vim.lsp.get_active_clients({ bufnr = original_bufnr })
                            ---@diagnostic disable-next-line: undefined-field
                            return #vim.tbl_keys(buf_clients) > 0 and utils.fg('Character') or utils.fg('Comment')
                        end,
                        on_click = function()
                            vim.cmd('LspInfo')
                        end,
                        icon = ' ',
                    },
                    { 'filename', path = 1, file_status = false },
                },
                lualine_x = {},
                lualine_y = { { utils.showRecording, color = utils.fg('Error') } },
                lualine_z = {
                    {
                        function()
                            return '󰐅'
                        end,
                        cond = function()
                            return utils.is_loaded('nvim-treesitter') ~= nil
                        end,
                        color = function()
                            return vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil
                                    and utils.fg('boolean')
                                or utils.fg('Comment')
                        end,
                        on_click = utils.toggle_treesitter_highlight,
                    },
                    {
                        function()
                            return ''
                        end,
                        color = function()
                            return vim.diagnostic.is_enabled() and utils.fg('boolean') or utils.fg('Comment')
                        end,
                        on_click = utils.toggle_diagnostic,
                    },
                    {
                        function()
                            return '󰓽'
                        end,
                        color = function()
                            return vim.lsp.inlay_hint.is_enabled() and utils.fg('boolean') or utils.fg('Comment')
                        end,
                        on_click = utils.toggle_inlay_hints,
                    },
                    {
                        function()
                            return '󰦦'
                        end,
                        color = function()
                            ---@diagnostic disable-next-line: undefined-field
                            return tonumber(vim.opt.conceallevel:get()) > 1 and utils.fg('boolean')
                                or utils.fg('Comment')
                        end,
                        on_click = utils.toggle_conceal,
                    },
                    {
                        function()
                            return '󰀫'
                        end,
                        color = function()
                            return vim.opt.list:get() and utils.fg('boolean') or utils.fg('Comment')
                        end,
                        on_click = utils.toggle_list,
                    },
                    {
                        function()
                            return ''
                        end,
                        on_click = utils.toggle_relative_number,
                        color = function()
                            ---@diagnostic disable-next-line: undefined-field
                            return vim.opt.relativenumber:get() and utils.fg('boolean') or utils.fg('Comment')
                        end,
                    },
                    {
                        function()
                            return ''
                        end,
                        on_click = utils.toggle_spell,
                        color = function()
                            ---@diagnostic disable-next-line: undefined-field
                            return vim.opt.spell:get() and utils.fg('boolean') or utils.fg('Comment')
                        end,
                    },
                    'location',
                    {
                        'progress',
                        cond = function()
                            return utils.is_loaded('scrollbar') == false
                        end,
                    },
                    function()
                        local icon = ' '
                        return icon .. os.date('%R')
                    end,
                },
            },
            winbar = {
                lualine_a = {
                    {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        symbols = {
                            modified = '󰏫',
                            readonly = '',
                            unnamed = '[No Name]',
                            newfile = '[New]',
                        },
                    },
                },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        'diagnostics',
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                },
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {
                    {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        symbols = {
                            modified = '󰏫',
                            readonly = '',
                            unnamed = '[No Name]',
                            newfile = '[New]',
                        },
                    },
                },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
    end,
}
