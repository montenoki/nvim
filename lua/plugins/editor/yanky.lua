return {
    "gbprod/yanky.nvim",
    keys = {
        -- 可视模式使用原生替换，普通模式仍由 Yanky 提供粘贴和历史切换。
        { "p", false, mode = "x" },
        { "P", false, mode = "x" },
    },
}
