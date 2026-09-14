return {
    "mrcjkb/rustaceanvim",
    opts = {
        dap = {
            adapter = false,
            configuration = false,
            autoload_configurations = false,
        },
        server = {
            -- LazyVim 的 on_attach 同时添加调试键；这里只保留代码操作。
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<leader>cR", function()
                    vim.cmd.RustLsp("codeAction")
                end, {
                    desc = "Rust 代码操作",
                    buffer = bufnr,
                })
            end,
        },
    },
    -- LazyVim 的 config 在 Mason 启用时重写 dap.adapter；直接交给插件读取选项，
    -- 让 Nix 和 Mason 两种环境都遵守上面的调试边界。
    config = function(_, opts)
        vim.g.rustaceanvim = opts
        if vim.fn.executable("rust-analyzer") == 0 then
            LazyVim.error(
                "未找到 rust-analyzer，请在项目环境中提供语言服务器。",
                { title = "rustaceanvim" }
            )
        end
    end,
}
