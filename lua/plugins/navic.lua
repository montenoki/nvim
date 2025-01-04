return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            table.insert(
                opts.winbar.lualine_c,
                { "navic", color_correction = "dynamic" }
            )
        end,
    },
}
