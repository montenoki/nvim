return {
    "dstein64/nvim-scrollview",
    opts = {
        -- 只显示可拖动的滚动条；诊断、搜索等标记已有各自的显示位置。
        signs_on_startup = {},
        -- 把手与文字重叠时隐藏，避免遮住长行末尾。
        hide_on_text_intersect = true,
        -- 文件树由自身负责导航，避免在侧栏叠加滚动条。
        excluded_filetypes = { "neo-tree" },
    },
}
