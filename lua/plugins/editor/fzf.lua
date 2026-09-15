return {
    {
        "ibhagwan/fzf-lua",
        opts = {
            -- 文件发现统一 cwd；内容搜索由 LazyVim.pick 使用项目根目录。
            files = { actions = { ["ctrl-r"] = false, ["alt-c"] = false } },
            oldfiles = { actions = { ["ctrl-r"] = false, ["alt-c"] = false } },
        },
        keys = {
            { '<leader>s"', false }, -- 寄存器当前内容；迁到 leader "。
            { "<leader>s/", false }, -- 原生搜索历史；迁到 leader h/。
            { "<leader>sa", false }, -- 自动命令列表；保留 :FzfLua autocmds。
            { "<leader>sb", false }, -- 多缓冲区行列表；文件内使用原生 /。
            { "<leader>sc", false }, -- 命令历史；迁到 leader h:。
            { "<leader>sC", false }, -- 可执行命令列表；迁到 leader :。
            { "<leader>sg", false }, -- 项目内容搜索；统一使用 leader / 和启动页 g。
            { "<leader>sG", false }, -- cwd 内容搜索；取消独立范围入口。
            { "<leader>sh", false }, -- 帮助主题列表；保留 :help。
            { "<leader>sH", false }, -- 高亮组列表；保留 :FzfLua highlights。
            { "<leader>sj", false }, -- 跳转历史；迁到 leader hj。
            { "<leader>sk", false }, -- 快捷键列表；使用 Which-key 提示。
            { "<leader>sM", false }, -- Man 手册列表；保留 :Man。
            { "<leader>sm", false }, -- 标记列表；迁到 leader m。
            { "<leader>sR", false }, -- 恢复最近一次选择器；迁到 leader r。
            { "<leader>sw", false, mode = { "n", "x" } }, -- 光标词或选区搜索。
            { "<leader>sW", false, mode = { "n", "x" } }, -- cwd 光标词或选区搜索。
            {
                "<leader>/",
                LazyVim.pick("live_grep"),
                desc = "检索",
            },
            {
                '<leader>"',
                "<cmd>FzfLua registers<cr>",
                desc = "寄存器列表",
            },
            { "<leader>m", "<cmd>FzfLua marks<cr>", desc = "标记列表" },
            { "<leader>hj", "<cmd>FzfLua jumps<cr>", desc = "跳转历史" },
            {
                "<leader>h/",
                "<cmd>FzfLua search_history<cr>",
                desc = "搜索历史",
            },
            {
                "<leader>h:",
                "<cmd>FzfLua command_history<cr>",
                desc = "命令历史",
            },
            {
                "<leader>:",
                "<cmd>FzfLua commands<cr>",
                desc = "Command 列表",
            },
            -- resume 恢复最近一次 fzf-lua 选择器，不限于内容搜索。
            {
                "<leader>r",
                "<cmd>FzfLua resume<cr>",
                desc = "恢复搜索结果",
            },
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
