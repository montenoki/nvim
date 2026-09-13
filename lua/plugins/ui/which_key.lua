local describe = require("config.ui.key_descriptions")

return {
    {
        "folke/which-key.nvim",
        keys = function(_, keys)
            -- 直接修改继承条目的 desc，保留函数；仅追加同名键会覆盖原动作。
            for _, key in ipairs(keys) do
                if type(key.desc) == "string" then
                    key.desc = describe(key.desc)
                end
            end
            return keys
        end,
        opts = function(_, opts)
            -- 就地翻译继承的分组，保留 buffer 的 expand 和 windows 的 proxy。
            -- 不重复声明同一组，避免覆盖动态列表或产生重复分组警告。
            local function translate_groups(spec)
                -- Leap Extra 已把 mini.surround 从 gs 移到 gz，菜单跟随实际前缀。
                if spec[1] == "gs" and spec.group == "surround" then
                    spec[1] = "gz"
                end
                if type(spec.group) == "string" then
                    spec.group = describe(spec.group)
                end
                for _, child in ipairs(spec) do
                    if type(child) == "table" then
                        translate_groups(child)
                    end
                end
            end
            opts.spec = opts.spec or {}
            translate_groups(opts.spec)
            vim.list_extend(opts.spec, {
                -- Avante 的上游映射使用 v，同时覆盖 Visual 和 Select 模式。
                {
                    "<leader>a",
                    mode = { "n", "v" },
                    group = "AI 助手",
                    icon = { icon = "󰧑", color = "blue" },
                },
                { "<leader>dP", group = "Python 调试", mode = "n" },
                { "<leader>t", group = "任务", mode = "n" },
            })
        end,
        config = function(_, opts)
            require("which-key").setup(opts)
            -- setup 合并完默认清理规则（如去掉 +、<Cmd>）后，追加完整描述翻译。
            -- 不创建映射；保留上游及个人已有的 replace 规则。
            table.insert(
                require("which-key.config").options.replace.desc,
                describe
            )
        end,
    },
}
