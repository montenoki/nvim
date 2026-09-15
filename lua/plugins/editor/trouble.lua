return {
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>xX", false }, -- 当前文件诊断列表；统一使用 xx 查看全部已收集诊断。
            { "<leader>cs", false }, -- 文件符号树；迁到 leader o，称为“文件大纲”。
            { "<leader>cS", false }, -- LSP 定义、引用等导航列表；迁到 leader k。
            { "<leader>xL", false }, -- Trouble 位置列表；取消专用入口，保留原生 :lopen。
            { "<leader>xQ", false }, -- Trouble Quickfix 列表；统一到小写 xq。
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "诊断列表",
            },
            {
                "<leader>o",
                "<cmd>Trouble symbols toggle<cr>",
                desc = "大纲",
            },
            {
                "<leader>k",
                "<cmd>Trouble lsp toggle<cr>",
                desc = "查看当前符号相关代码",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        keys = {
            { "[t", false }, -- 跳到上一个 TODO 标记；改为在 xt 列表内选择。
            { "]t", false }, -- 跳到下一个 TODO 标记；改为在 xt 列表内选择。
            { "<leader>xT", false }, -- Trouble 的 TODO/FIX/FIXME 子集列表；统一使用 xt 全部标记。
            { "<leader>st", false }, -- 通过搜索选择器查找全部 TODO 标记；统一使用 xt。
            { "<leader>sT", false }, -- 通过搜索选择器查找 TODO/FIX/FIXME 子集；统一使用 xt。
            {
                "<leader>xt",
                function()
                    -- todo-comments 的 Trouble source 在每次搜索时读取 cwd。
                    require("trouble").toggle("todo")
                end,
                desc = "TODO 列表",
            },
        },
    },
}
