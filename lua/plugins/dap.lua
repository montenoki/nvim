local keymaps = require('keymaps')
local utils = require('utils')
local config = require('config')

return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            -- virtual text for the debugger
            { 'theHamsta/nvim-dap-virtual-text', opts = {} },
        },
        init = function()
            require('which-key').add({ { '<LEADER>d', group = '+Debug', mode = { 'n', 'v' } } })
        end,
        -- stylua: ignore
        keys = {
            { keymaps.dap.breakpoint, function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { keymaps.dap.breakpoint_cond, function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { keymaps.dap.continue, function() require("dap").continue() end, desc = "Continue" },
            { keymaps.dap.run_with_args, function() require("dap").continue({ before = utils.getArgs }) end, desc = "Run with Args" },
            { keymaps.dap.run_to_cursor, function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { keymaps.dap.goto_line, function() require("dap").goto_() end, desc = "Go to line (no execute)" },
            { keymaps.dap.step_into, function() require("dap").step_into() end, desc = "Step Into" },
            { keymaps.dap.down, function() require("dap").down() end, desc = "Down" },
            { keymaps.dap.up, function() require("dap").up() end, desc = "Up" },
            { keymaps.dap.run_last, function() require("dap").run_last() end, desc = "Run Last" },
            { keymaps.dap.step_out, function() require("dap").step_out() end, desc = "Step Out" },
            { keymaps.dap.step_over, function() require("dap").step_over() end, desc = "Step Over" },
            { keymaps.dap.pause, function() require("dap").pause() end, desc = "Pause" },
            { keymaps.dap.repl, function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { keymaps.dap.session, function() require("dap").session() end, desc = "Session" },
            { keymaps.dap.terminate, function() require("dap").terminate() end, desc = "Terminate" },
            { keymaps.dap.widgets, function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },

        config = function()
            if utils.has('mason-nvim-dap.nvim') then
                require('mason-nvim-dap').setup(utils.opts('mason-nvim-dap.nvim'))
            end
            vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
            for name, sign in pairs(config.icons.dap) do
                sign = type(sign) == 'table' and sign or { sign }
                vim.fn.sign_define(
                    'Dap' .. name,
                    { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
                )
            end
            -- setup dap config by VsCode launch.json file
            local vscode = require('dap.ext.vscode')
            local json = require('plenary.json')
            vscode.json_decode = function(str)
                return vim.json.decode(json.json_strip_comments(str))
            end
            -- Extends dap.configurations with entries read from .vscode/launch.json
            if vim.fn.filereadable('.vscode/launch.json') then
                vscode.load_launchjs()
            end
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { { 'nvim-neotest/nvim-nio' } },
        keys = {
            {
                keymaps.dap.ui,
                function()
                    require('dapui').toggle({})
                end,
                desc = 'Dap UI',
            },
            {
                keymaps.dap.eval,
                function()
                    require('dapui').eval()
                end,
                desc = 'Dap Eval',
                mode = { 'n', 'v' },
            },
        },
        opts = {
            controls = {
                element = 'repl',
                enabled = vim.g.lite_mode and false or true,
                icons = config.icons.dapUI.controls,
            },
            icons = config.icons.dapUI.status,
        },
        config = function(_, opts)
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup(opts)
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close({})
            end
        end,
    },

    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = 'mason.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        opts = {
            automatic_installation = true,
            handlers = {},
            ensure_installed = {},
        },
        config = function() end,
    },
}
