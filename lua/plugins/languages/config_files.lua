-- JSON/YAML/TOML 的 LSP 与 SchemaStore 由各自 Extra 提供。
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                vimls = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                ["yaml.docker-compose"] = { "prettier" },
                ["yaml.ansible"] = { "prettier" },
                toml = { "taplo" },
            },
        },
    },
}
