-- 配色插件及系统主题接线；主题选择和监听由 config.ui.theme 负责。
return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
                require("config.ui.theme").setup()
            end,
        },
    },
    { "folke/tokyonight.nvim", opts = { style = "night" } },
    { "rebelot/kanagawa.nvim", lazy = true, opts = {} },
    { "OldJobobo/retro-82.nvim", lazy = true },
    { "shaunsingh/nord.nvim", lazy = true },
    { "bjarneo/ethereal.nvim", lazy = true },
    {
        "neanias/everforest-nvim",
        lazy = true,
        main = "everforest",
        opts = { background = "soft" },
    },
    { "kepano/flexoki-neovim", lazy = true },
    {
        "bjarneo/hackerman.nvim",
        lazy = true,
        dependencies = { "bjarneo/aether.nvim" },
    },
    { "omacom-io/lumon.nvim", lazy = true },
    { "tahayvr/matteblack.nvim", lazy = true },
    { "OldJobobo/miasma.nvim", lazy = true },
    { "ribru17/bamboo.nvim", lazy = true, opts = {} },
    {
        "loctvl842/monokai-pro.nvim",
        lazy = true,
        opts = { filter = "ristretto" },
    },
    { "rose-pine/neovim", name = "rose-pine", lazy = true },
    { "bjarneo/vantablack.nvim", lazy = true },
    { "bjarneo/white.nvim", lazy = true },
    { "ficcdaf/ashen.nvim", lazy = true },
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        init = function()
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_foreground = "material"
        end,
    },
}
