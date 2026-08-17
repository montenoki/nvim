local platform = require("config.platform")

return {
    {
        "mason-org/mason.nvim",
        enabled = not platform.nix_managed_tools,
        opts = {
            ensure_installed = {
                "bash-language-server",
                "bash-debug-adapter",
                "debugpy",
                "taplo",
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = not platform.nix_managed_tools,
    },
}
