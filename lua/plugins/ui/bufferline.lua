return {
    {
        "akinsho/bufferline.nvim",
        keys = {
            { "[b", false }, -- 切换上一个缓冲区；保留 Shift-h。
            { "]b", false }, -- 切换下一个缓冲区；保留 Shift-l。
            { "[B", false }, -- 将当前标签向前移动，调整标签顺序。
            { "]B", false }, -- 将当前标签向后移动，调整标签顺序。
            { "<leader>bP", false }, -- 关闭未固定的缓冲区；取消固定相关入口。
            { "<leader>br", false }, -- 关闭当前标签右侧的缓冲区；关闭入口仅保留 bd/bo。
            { "<leader>bl", false }, -- 关闭当前标签左侧的缓冲区；关闭入口仅保留 bd/bo。
            { "<leader>bj", false }, -- 按字母选择缓冲区；迁到 bp，替换原来的固定开关。
            {
                "<leader>bp",
                "<cmd>BufferLinePick<cr>",
                desc = "字母选择",
            },
        },
        opts = {
            options = {
                show_buffer_close_icons = false,
                show_close_icon = false,
                close_command = function() end,
                right_mouse_command = function() end,
                middle_mouse_command = function() end,
            },
        },
    },
}
