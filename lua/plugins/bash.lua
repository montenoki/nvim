return {
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "bash-language-server",
                "bash-debug-adapter",
            },
        },
    },
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
