local keymapping = require("keymapping")

return {
    {
        "ggandor/flit.nvim",
        enabled = true,
        keys = function()
            local ret = {}
            for _, key in ipairs({ "f", "F", "t", "T" }) do
                ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
            end
            return ret
        end,
        opts = { labeled_modes = "nx" },
    },
    { "tpope/vim-repeat", event = "VeryLazy" },
    {
        "ggandor/leap.nvim",
        keys = {
            {
                keymapping.leap,
                mode = { "n", "x", "o" },
                function()
                    local leap = require("leap")
                    leap.leap({
                        target_windows = vim.tbl_filter(function(win)
                            return vim.api.nvim_win_get_config(win).focusable
                        end, vim.api.nvim_tabpage_list_wins(
                            0
                        )),
                    })
                end,
                desc = "Leap",
            },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            leap.opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
            vim.keymap.del({ "n", "x", "o" }, "gs")
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
    {
        "echasnovski/mini.surround",
        optional = false,
        opts = {
            mappings = {
                add = "gza", -- Add surrounding in Normal and Visual modes
                delete = "gzd", -- Delete surrounding
                find = "gzf", -- Find surrounding (to the right)
                find_left = "gzF", -- Find surrounding (to the left)
                highlight = "gzh", -- Highlight surrounding
                replace = "gzr", -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
        keys = {
            { "gz", "", desc = "+surround" },
        },
    },
}
