if true then
    return {}
else
    return {
        -- jupytext change(ipynb -> py)
        {
            "GCBallesteros/jupytext.nvim",
            config = true,
            -- ft = "ipynb",
            lazy = false,
        },
        --  cell run
        {
            "GCBallesteros/NotebookNavigator.nvim",
            keys = {
                {
                    "]h",
                    function()
                        require("notebook-navigator").move_cell("d")
                    end,
                },
                {
                    "[h",
                    function()
                        require("notebook-navigator").move_cell("u")
                    end,
                },
                {
                    "<leader>rc",
                    "<cmd>lua require('notebook-navigator').run_cell()<cr>",
                },
                {
                    "<leader>rm",
                    "<cmd>lua require('notebook-navigator').run_and_move()<cr>",
                },
            },
            dependencies = {
                "echasnovski/mini.comment",
                "anuvyklack/hydra.nvim",
                {
                    "benlubas/molten-nvim",
                    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
                    dependencies = {
                        {
                            "3rd/image.nvim",
                            opts = {
                                backend = "kitty", -- whatever backend you would like to use
                                max_width = 500,
                                max_height = 500,
                                max_height_window_percentage = math.huge,
                                max_width_window_percentage = math.huge,
                                window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
                                window_overlap_clear_ft_ignore = {
                                    "cmp_menu",
                                    "cmp_docs",
                                    "",
                                },
                            },
                        },
                    },
                    build = ":UpdateRemotePlugins",
                    -- cmd = "MoltenInit",
                    init = function()
                        -- these are examples, not defaults. Please see the readme
                        vim.g.molten_image_provider = "image.nvim"
                        vim.g.molten_output_win_max_height = 500
                        -- vim.g.molten_auto_open_output = true
                        -- vim.g.molten_virt_text_output = true
                        -- vim.g.molten_virt_lines_off_by_1 = true
                    end,
                },
            },
            event = "VeryLazy",
            config = function()
                local nn = require("notebook-navigator")
                nn.setup({
                    activate_hydra_keys = "<leader>h",
                    repl_provider = "molten",
                })
            end,
        },
    }
end
