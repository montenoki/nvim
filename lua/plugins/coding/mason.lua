local platform = require("config.platform")

return {
    {
        "mason-org/mason.nvim",
        enabled = not platform.nix_managed_tools,
        opts = function(_, opts)
            -- Rust Extra 会追加 codelldb；Neovim 不再安装专用调试器。
            opts.ensure_installed = vim.tbl_filter(function(tool)
                return tool ~= "codelldb" and tool ~= "debugpy"
            end, opts.ensure_installed or {})
            vim.list_extend(opts.ensure_installed, {
                "bash-language-server",
                "prettier",
                "shellcheck",
                "taplo",
                "nil",
                "nixfmt",
                "statix",
            })
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = not platform.nix_managed_tools,
    },
}
