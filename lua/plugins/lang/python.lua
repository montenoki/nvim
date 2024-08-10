local keymaps = require('keymaps')
local utils = require('utils')

return {
    {
        'linux-cultist/venv-selector.nvim',
        branch = 'regexp', -- Use this branch for the new version
        cmd = 'VenvSelect',
        lazy = false,
        --  Call config for python files and load the cached venv automatically
        ft = 'python',
        keys = { { keymaps.python.venv_select, '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' } },
        init = function()
            vim.g.python_version = ''
        end,
        config = function()
            local function on_venv_activate()
                local python_exec = require('venv-selector').python()
                vim.g.python_version = utils.getPythonVersion(python_exec)
            end

            require('venv-selector').setup({
                settings = {
                    options = {
                        on_venv_activate_callback = on_venv_activate,
                    },
                },
            })
        end,
    },
    -- ===========================================================================
    -- treesitter
    -- ===========================================================================
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'python', 'toml' })
            end
        end,
    },
    -- ===========================================================================
    -- lsp
    -- ===========================================================================
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = 'workspace',
                                exclude = { 'tests', 'test', 'dist', 'build', '.venv', '.git' },
                                typeCheckingMode = 'standard',
                            },
                        },
                    },
                },
                ruff_lsp = {
                    keys = {
                        { keymaps.lsp.organize, utils.action['source.organizeImports'], desc = 'Organize Imports' },
                    },
                },
            },
            setup = {
                ruff_lsp = function()
                    utils.lspOnAttach(function(client, _)
                        if client.name == 'ruff_lsp' then
                            -- Disable hover in favor of Pyright
                            client.server_capabilities.hoverProvider = false
                        end
                    end)
                end,
            },
        },
    },
    -- =========================================================================
    -- formatter
    -- =========================================================================
    {
        'stevearc/conform.nvim',
        opts = function(_, opts)
            local python_formatter = { python = { 'ruff_format' } }
            if type(opts.formatters_by_ft) == 'table' then
                opts.formatters_by_ft = vim.tbl_deep_extend('force', opts.formatters_by_ft, python_formatter)
            end
        end,
    },
    -- =========================================================================
    -- dap
    -- =========================================================================
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'mfussenegger/nvim-dap-python',
            keys = {
                {
                    '<leader>dPt',
                    function()
                        require('dap-python').test_method()
                    end,
                    desc = 'Debug Method',
                    ft = 'python',
                },
                {
                    '<leader>dPc',
                    function()
                        require('dap-python').test_class()
                    end,
                    desc = 'Debug Class',
                    ft = 'python',
                },
            },
            config = function()
                utils.ensureDebugpy(require('venv-selector').python())
                require('dap-python').setup(require('venv-selector').python())
            end,
        },
    }, -- ===========================================================================
    -- mason
    -- ===========================================================================
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                vim.list_extend(opts.ensure_installed, { 'ruff' })
            end
        end,
    },
    -- ===========================================================================
    -- lualine
    -- ===========================================================================
    {
        'lualine.nvim',
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, {
                function()
                    return vim.g.python_version
                end,
                cond = function()
                    return vim.bo.filetype == 'python'
                end,
                on_click = function()
                    vim.cmd.VenvSelect()
                end,
                icon = '🐍',
                color = utils.fg('character'),
            })
        end,
    },
}
