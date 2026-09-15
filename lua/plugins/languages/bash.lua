return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                bashls = {},
                fish_lsp = {},
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                sh = { "shfmt" },
                bash = { "shfmt" },
                fish = { "fish_indent" },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        -- Bash LS 调用 ShellCheck；Zsh 使用自己的解析器，避免 Bash 误报。
        opts = {
            linters_by_ft = { zsh = { "zsh" } },
            linters = {
                zsh = {
                    -- libuv 的 stdin 是管道，Zsh 重新打开 /dev/stdin 会失败。
                    -- -s 直接读取传入的 stdin，也能检查尚未保存的内容。
                    stdin = true,
                    args = { "--no-exec", "--no-rcs", "--no-globalrcs", "-s" },
                    parser = function(output, bufnr)
                        -- -s 的语法错误没有行号，作为文件级诊断显示在首行。
                        return require("lint.parser").from_errorformat(
                            "%E%*[^:]: %m",
                            {
                                source = "zsh",
                                severity = vim.diagnostic.severity.ERROR,
                            }
                        )(output, bufnr)
                    end,
                },
            },
        },
    },
}
