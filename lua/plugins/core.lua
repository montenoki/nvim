return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = function()
                require("config.theme").setup()
            end,
        },
    },
}
