return {
    {
        "ibhagwan/fzf-lua",
        opts = {
            -- 文件发现统一 cwd，其他内容搜索仍保留各自已有的范围操作。
            files = { actions = { ["ctrl-r"] = false, ["alt-c"] = false } },
            oldfiles = { actions = { ["ctrl-r"] = false, ["alt-c"] = false } },
        },
        keys = {
            { "<leader>,", false }, -- 按最近使用查找缓冲区；统一使用 leader fb。
            { "<leader>fB", false }, -- 缓冲区列表的另一入口；统一使用 leader fb。
            { "<leader>fc", false }, -- 查找 Neovim 配置文件；取消专用入口。
            { "<leader>ff", false }, -- 在项目根目录查找文件；统一使用 leader Space 的 cwd 搜索。
            { "<leader>fF", false }, -- 在 cwd 查找文件；合并到 leader Space。
            { "<leader>fg", false }, -- 查找 Git 文件；保留 :FzfLua git_files 命令。
            { "<leader>fR", false }, -- cwd 内最近文件；迁到 leader fr。
            { "<leader>gc", false }, -- 搜索 Git 提交历史；交给 Neogit／Lazygit。
            { "<leader>gd", false }, -- 搜索 Git 差异文件；交给 Neogit／Lazygit。
            { "<leader>gl", false }, -- 同 gc，搜索 Git 提交历史；交给两个 Git 客户端。
            { "<leader>gs", false }, -- 搜索 Git 状态文件；交给 Neogit／Lazygit。
            { "<leader>gS", false }, -- 搜索 Git stash 记录；交给 Neogit／Lazygit。
            { "<leader>sd", false }, -- 搜索全部已收集诊断；统一使用 Trouble xx。
            { "<leader>sD", false }, -- 搜索当前文件诊断；统一使用 Trouble xx。
            { "<leader>sl", false }, -- 搜索当前窗口的位置列表；保留原生 :lopen。
            { "<leader>sq", false }, -- 搜索 Quickfix 列表；统一使用 Trouble xq。
            { "<leader>ss", false }, -- 搜索当前文档符号；取消独立搜索，保留 leader o 文件大纲。
            { "<leader>sS", false }, -- 搜索工作区符号；跨文件定位改用项目内容搜索。
            {
                "<leader><space>",
                function()
                    require("fzf-lua").files({ cwd = vim.fn.getcwd() })
                end,
                desc = "查找文件",
            },
            {
                "<leader>fr",
                function()
                    require("fzf-lua").oldfiles({
                        cwd = vim.fn.getcwd(),
                        cwd_only = true,
                    })
                end,
                desc = "最近文件",
            },
            {
                "<leader>fb",
                function()
                    require("fzf-lua").buffers({
                        sort_mru = true,
                        sort_lastused = true,
                    })
                end,
                desc = "查找缓冲区",
            },
        },
    },
}
