return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            require("config.toggles").configure_lsp(opts)
        end,
    },
}
