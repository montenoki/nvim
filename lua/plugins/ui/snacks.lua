return {
    {
        "snacks.nvim",
        keys = {
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
                    action = ":lua Snacks.dashboard.pick('live_grep')",
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
