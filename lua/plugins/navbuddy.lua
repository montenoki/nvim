local keymapping = require("keymapping")

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim",
            },
            opts = { lsp = { auto_attach = true } },
        },
    },
    keys = {
        {
            keymapping.navbuddy,
            function()
                require("nvim-navbuddy").open()
            end,
            mode = "n",
            desc = "Open Navbuddy",
        },
    },
}
