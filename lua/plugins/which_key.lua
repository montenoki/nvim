return {
    {
        "folke/which-key.nvim",
        opts = {
            -- Ignore LazyVim's old virtual Zoom hint; wm belongs to WinShift.
            filter = function(mapping)
                if
                    mapping.real
                    and mapping.mode == "n"
                    and mapping.lhs == "<leader>wm"
                then
                    return false
                end
                return true
            end,
            spec = {
                {
                    mode = { "n", "v" },
                    {
                        "<LEADER>a",
                        group = "AI",
                        icon = { icon = "󰧑", color = "brue" },
                    },
                },
                { "<leader>wm", mode = "n", desc = "WinShift", icon = "" },
            },
        },
    },
}
