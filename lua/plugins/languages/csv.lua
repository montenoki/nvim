return {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle", "CsvViewInfo" },
    opts = {
        -- CSV 中的 # 和 // 可以是数据，不当成注释跳过。
        parser = { comments = {} },
        view = { display_mode = "border" },
        keymaps = {
            jump_next_field_end = {
                "]v",
                mode = { "n", "x" },
                desc = "下一字段末尾",
            },
            jump_prev_field_end = {
                "[v",
                mode = { "n", "x" },
                desc = "上一字段末尾",
            },
        },
    },
    config = function(_, opts)
        local csv = require("csvview")
        csv.setup(opts)
        -- 使用虚拟文字对齐，不修改原始数据，也不注册自动格式化器。
        local function enable(buf)
            if vim.tbl_contains({ "csv", "tsv" }, vim.bo[buf].filetype) then
                csv.enable(buf)
            end
        end
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup(
                "language_csv",
                { clear = true }
            ),
            pattern = { "csv", "tsv" },
            callback = function(ev)
                enable(ev.buf)
            end,
        })
        enable(vim.api.nvim_get_current_buf())
    end,
}
