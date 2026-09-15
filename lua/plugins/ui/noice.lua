return {
    "folke/noice.nvim",
    opts = {
        -- 通知由 Noice 收集，再交给 Snacks 显示；全部消息包含通知和多行报错。
        notify = { enabled = true },
        commands = {
            all = {
                view = "popup",
                opts = { enter = true, format = "details" },
                filter = {},
            },
        },
    },
    keys = {
        { "<leader>sn", false },
        { "<leader>snl", false },
        { "<leader>snh", false },
        { "<leader>sna", false },
        { "<leader>snt", false },
        { "<leader>snd", false },
        {
            "<leader>n",
            "<cmd>Noice all<cr>",
            desc = "全部消息",
        },
    },
}
