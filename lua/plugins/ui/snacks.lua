return {
    {
        "snacks.nvim",
        keys = {
            { "<leader>dps", false }, -- 取消性能分析临时缓冲区。
            { "<leader>n", false }, -- 全部消息统一由 Noice 提供文本分屏。
            { "<leader>un", false }, -- 取消一次性隐藏通知入口，保留正常通知显示。
            { "<leader>.", false }, -- 打开便笺迁到 leader p。
            { "<leader>S", false }, -- 便笺列表迁到 leader P。
            {
                "<leader>p",
                function()
                    Snacks.scratch()
                end,
                desc = "打开或关闭便笺",
            },
            {
                "<leader>P",
                function()
                    Snacks.scratch.select()
                end,
                desc = "便笺列表",
            },
        },
        opts = function(_, opts)
            -- 显式定义启动页入口，避免继承上游英文列表而跳过本地中文配置。
            local keys = {
                {
                    icon = " ",
                    key = "f",
                    desc = "查找",
                    action = function()
                        require("fzf-lua").files({ cwd = vim.fn.getcwd() })
                    end,
                },
                {
                    icon = " ",
                    key = "n",
                    desc = "新建",
                    action = ":ene | startinsert",
                },
                {
                    icon = " ",
                    key = "g",
                    desc = "搜索",
                    action = LazyVim.pick("live_grep"),
                },
                {
                    icon = " ",
                    key = "r",
                    desc = "最近文件",
                    action = function()
                        require("fzf-lua").oldfiles({
                            cwd = vim.fn.getcwd(),
                            cwd_only = true,
                        })
                    end,
                },
                {
                    icon = " ",
                    key = "s",
                    desc = "恢复会话",
                    section = "session",
                },
                {
                    icon = "󰒲 ",
                    key = "l",
                    desc = "Lazy",
                    action = ":Lazy",
                },
                { icon = " ", key = "q", desc = "退出", action = ":qa" },
            }
            opts.dashboard = opts.dashboard or {}
            opts.dashboard.preset = opts.dashboard.preset or {}
            -- Extras 只保留 :LazyExtras 命令入口，不加入启动页。
            opts.dashboard.preset.keys = keys
            -- Enter 对比当前编辑内容与选中提交中的文件版本。
            local function detail(picker, item)
                require("config.git_history").compare(picker, item)
            end
            return vim.tbl_deep_extend("force", opts, {
                -- 新便笺固定为 Markdown；从列表打开的已有便笺保留原文件类型。
                scratch = { ft = "markdown" },
                picker = {
                    sources = {
                        scratch = {
                            win = {
                                input = {
                                    footer_keys = { "<C-x>" },
                                    keys = {
                                        ["<CR>"] = { "confirm", mode = { "n", "i" }, desc = "打开" },
                                        ["<C-n>"] = { "scratch_new", mode = { "n", "i" }, desc = "新建" },
                                        ["<C-x>"] = { "scratch_delete", mode = { "n", "i" }, desc = "删除" },
                                        ["?"] = { "toggle_help_input", desc = "帮助" },
                                    },
                                },
                            },
                        },
                        git_log_file = { confirm = detail },
                        git_log_line = { confirm = detail },
                    },
                },
                dashboard = {
                    preset = {
                        header = [[
╔═════╗╔══╗    ╔╦╗  ╔═════╗
║ ▀ ▀ ║║╚═╬════╬╣╠═╗║ ▀ - ║
║╚═══╝║╠═╗║╔╗╔╗║║║╩╣║╚═══╝║
╚═════╝╚══╩╝╚╝╚╩╩╩═╝╚═════╝
Smile@2025
]],
                    },
                },
            })
        end,
    },
}
