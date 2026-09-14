return {
    {
        "snacks.nvim",
        keys = {
            { "<leader>n", false }, -- 全部消息统一由 Noice 提供文本分屏。
            { "<leader>un", false }, -- 取消一次性隐藏通知入口，保留正常通知显示。
            { "<leader>S", false }, -- 选择已保存的草稿；迁到 leader qn，leader . 仍用于打开草稿。
            {
                "<leader>qn",
                function()
                    Snacks.scratch.select()
                end,
                desc = "选择已保存草稿",
            },
        },
        opts = function(_, opts)
            local keys = {
                { icon = " ", key = "f", desc = "查找文件" },
                {
                    icon = " ",
                    key = "n",
                    desc = "新建文件",
                    action = ":ene | startinsert",
                },
                {
                    icon = " ",
                    key = "g",
                    desc = "搜索内容",
                    action = LazyVim.pick("live_grep"),
                },
                { icon = " ", key = "r", desc = "最近文件" },
                {
                    icon = " ",
                    key = "s",
                    desc = "恢复会话",
                    section = "session",
                },
                {
                    icon = "󰒲 ",
                    key = "L",
                    desc = "插件管理",
                    action = ":Lazy",
                },
                { icon = " ", key = "q", desc = "退出", action = ":qa" },
            }
            opts.dashboard = opts.dashboard or {}
            opts.dashboard.preset = opts.dashboard.preset or {}
            opts.dashboard.preset.keys = vim.tbl_filter(function(key)
                if key.key == "f" then
                    key.desc = "查找文件"
                    key.action = function()
                        require("fzf-lua").files({ cwd = vim.fn.getcwd() })
                    end
                elseif key.key == "g" then
                    -- 与 leader / 共用项目根目录解析，避免启动页默认使用 cwd。
                    key.action = LazyVim.pick("live_grep")
                elseif key.key == "r" then
                    key.desc = "最近文件"
                    key.action = function()
                        require("fzf-lua").oldfiles({
                            cwd = vim.fn.getcwd(),
                            cwd_only = true,
                        })
                    end
                end
                return key.key ~= "c"
            end, opts.dashboard.preset.keys or keys)
            -- Enter 对比当前编辑内容与选中提交中的文件版本。
            local function detail(picker, item)
                require("config.git_history").compare(picker, item)
            end
            return vim.tbl_deep_extend("force", opts, {
                picker = {
                    sources = {
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
