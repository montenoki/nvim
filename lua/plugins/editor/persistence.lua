return {
    {
        "folke/persistence.nvim",
        keys = {
            { "<leader>qS", false }, -- 选择已保存的会话并恢复；仅保留 qs 和启动页 s 恢复当前项目。
            { "<leader>ql", false }, -- 恢复最近一次会话，可能来自其他项目。
            { "<leader>qd", false }, -- 停止保存本次会话；取消此入口，继续自动保存。
        },
    },
}
