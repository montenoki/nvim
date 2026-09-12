return {
    {
        "hotoo/pangu.vim",
        lazy = true,
        -- 直接执行命令时也能加载插件，无需先按快捷键。
        cmd = { "Pangu", "PanguAll", "PanguEnable", "PanguDisable" },
        keys = {
            {
                "<leader>cz",
                "<Cmd>PanguAll<CR>",
                mode = "n",
                desc = "中文排版：全文",
            },
            {
                "<leader>cz",
                -- 保留可视选区的行范围；即使只选中部分字符，也处理整行。
                ":Pangu<CR>",
                mode = "x",
                desc = "中文排版：选中行",
            },
        },
        -- 仅手动执行；Pangu 不会自动避开 Markdown 代码块和行内代码。
    },
}
