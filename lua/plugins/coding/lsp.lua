-- LSP 配置接线入口
-- 合并到已有 nvim-lspconfig，注册遵循保存偏好的连接回调。
return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            require("config.toggles").configure_lsp(opts)
            vim.list_extend(opts.servers["*"].keys, {
                { "<leader>cl", false }, -- LSP 信息保留命令入口。
                { "gK", false },
                { "<leader>cC", false },
                { "<leader>cR", false },
                { "<leader>cA", false },
            })
        end,
    },
}
