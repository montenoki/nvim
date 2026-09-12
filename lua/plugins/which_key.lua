return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                -- 只定义菜单分组及图标，具体快捷键和执行动作由各插件管理。
                -- 普通模式和可视/选择模式都显示 AI 分组。
                {
                    "<leader>a",
                    mode = { "n", "v" },
                    group = "AI",
                    icon = { icon = "󰧑", color = "blue" },
                },
            },
        },
    },
}
