-- LSP 配置接线入口
-- 合并到已有 nvim-lspconfig，注册遵循保存偏好的连接回调。
return {
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            require("config.toggles").configure_lsp(opts)
        end,
    },
}
