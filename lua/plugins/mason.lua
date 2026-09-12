local platform = require("config.platform")

return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        -- Nix 环境的调试器由项目 devShell 提供。
        enabled = not platform.nix_managed_tools,
    },
    {
        "mason-org/mason.nvim",
        enabled = not platform.nix_managed_tools,
        opts = {
            ensure_installed = {
                "bash-language-server",
                "prettier",
                "shellcheck",
                "debugpy",
                "taplo",
                "nil",
                "nixfmt",
                "statix",
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = not platform.nix_managed_tools,
    },
}
