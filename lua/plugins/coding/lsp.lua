-- LSP 配置接线入口
-- 合并到已有 nvim-lspconfig，注册遵循保存偏好的连接回调。
return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            require("config.toggles").configure_lsp(opts)
            vim.list_extend(opts.servers["*"].keys, {
                { "<leader>cl", false }, -- LSP 信息保留命令入口。
                { "gK", false }, -- 显示函数签名与参数帮助。
                { "<leader>cC", false }, -- 刷新并显示 CodeLens（代码上方的操作提示）。
                { "<leader>cR", false }, -- 重命名文件，并通知支持该能力的 LSP 更新引用。
                { "<leader>cA", false }, -- 文件级代码操作（Source Action，如整理导入，取决于 LSP）。
            })
        end,
    },
}
