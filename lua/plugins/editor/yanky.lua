return {
    "gbprod/yanky.nvim",
    keys = {
        { "<leader>p", false, mode = { "n", "x" } }, -- 复制历史迁到 leader hy。
        {
            "<leader>hy",
            "<cmd>YankyRingHistory<cr>",
            mode = { "n", "x" },
            desc = "复制历史",
        },
        -- 可视模式使用原生替换，普通模式仍由 Yanky 提供粘贴和历史切换。
        { "p", false, mode = "x" },
        { "P", false, mode = "x" },
    },
}
