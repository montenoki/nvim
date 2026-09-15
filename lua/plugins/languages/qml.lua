return {
    {
        "neovim/nvim-lspconfig",
        -- Nix 的 qmlls wrapper 提供 Qt / Quickshell 模块路径。
        opts = { servers = { qmlls = {} } },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                qml = { "qmlformat" },
                qmljs = { "qmlformat" },
                -- 由项目显式声明的 Qt JS 资源使用 Qt 格式化器。
                ["javascript.qml"] = { "qmlformat" },
            },
        },
    },
}
