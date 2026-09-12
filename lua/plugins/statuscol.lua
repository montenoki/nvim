return {
    "luukvbaal/statuscol.nvim",
    opts = function()
        local builtin = require("statuscol.builtin")
        return {
            -- 相对行号模式下，将光标所在行的行号右对齐。
            relculright = true,
            -- 从左到右：折叠按钮、诊断/Git 标记、行号；保留鼠标点击操作。
            segments = {
                { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                { text = { "%s" }, click = "v:lua.ScSa" },
                { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
        }
    end,
}
