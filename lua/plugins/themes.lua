return {
    { "folke/tokyonight.nvim", opts = { style = "night" } },
    { "rebelot/kanagawa.nvim", lazy = true, opts = {} },
    { "OldJobobo/retro-82.nvim", lazy = true },
    { "shaunsingh/nord.nvim", lazy = true },
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        init = function()
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_foreground = "material"
        end,
    },
}
