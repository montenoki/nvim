local utils = require("utils")

local function on_venv_activate()
    local python_exec = require("venv-selector").python()
    local ver, err = utils.get_python_version(python_exec)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
    else
        vim.g.venv_python_version = ver
    end
end

return {
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "debugpy",
            },
        },
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            {
                "<LEADER>cv",
                "<cmd>:VenvSelect<cr>",
                desc = "Select VirtualEnv",
                ft = "python",
            },
        },
        init = function()
            vim.g.venv_python_version = ""
        end,
        opts = {
            settings = {
                options = { on_venv_activate_callback = on_venv_activate },
            },
        },
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     opts = {
    --         servers = {
    --             basedpyright = {
    --                 settings = {
    --                     basedpyright = {
    --                         analysis = {
    --                             diagnosticSeverityOverrides = {
    --                                 -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
    --                                 reportUndefinedVariable = "error",
    --                                 reportUnusedVariable = "warning", -- or anything
    --                                 reportUnknownParameterType = false,
    --                                 reportUnknownArgumentType = false,
    --                                 reportUnknownLambdaType = false,
    --                                 reportUnknownVariableType = false,
    --                                 reportUnknownMemberType = false,
    --                                 reportMissingParameterType = false,
    --                             },
    --                             typeCheckingMode = "off",
    --                         },
    --                     },
    --                 },
    --             },
    --         },
    --     },
    -- },
    {
        "lualine.nvim",
        opts = function(_, opts)
            table.insert(opts.sections.lualine_x, {
                function()
                    return vim.g.venv_python_version
                end,
                cond = function()
                    return vim.bo.filetype == "python"
                end,
                on_click = function()
                    vim.cmd.VenvSelect()
                end,
                icon = "🐍",
            })
        end,
    },
}
