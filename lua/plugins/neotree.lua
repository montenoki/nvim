local keymapping = require("keymapping")

return {
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = { hint = "floating-big-letter" },
        keys = {
            {
                keymapping.window_picker,
                function()
                    local picked_window_id =
                        require("window-picker").pick_window({
                            hint = "floating-big-letter",
                        })
                    if picked_window_id then
                        vim.api.nvim_set_current_win(picked_window_id)
                    end
                end,
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            window = {
                mappings = {
                    ["v"] = "vsplit_with_window_picker",
                    ["s"] = "split_with_window_picker",
                    ["S"] = "none",
                    ["<CR>"] = "open_with_window_picker",
                },
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- Change type
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "󰢤",
                        staged = "",
                        conflict = "",
                    },
                },
            },
        },
    },
}
