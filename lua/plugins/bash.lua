return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                bashls = {
                    settings = {
                        filetypes = { "sh", "zsh" },
                    },
                },
            },
        },
    },
}
