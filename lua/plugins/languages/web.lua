-- 零散 JS/TS 与 HTML/CSS 也可用；项目运行依赖仍由项目管理。
return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                html = {},
                cssls = {},
                ts_ls = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                less = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
            },
        },
    },
}
