return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {
                    mode = { "n", "v" },
                    {
                        "<LEADER>a",
                        group = "AI",
                        icon = { icon = "󰧑", color = "brue" },
                    },
                    { "<LEADER>wm", desc = "Windows Manager", icon = "" },
                },
            },
        },
    },
}
