return {
    {
        "lewis6991/gitsigns.nvim",
        opts = function(_, opts)
            local attach = opts.on_attach
            opts.on_attach = function(buf)
                if attach then
                    local result = attach(buf)
                    if result == false then
                        return false
                    end
                end
                -- 复用上游的 diff/普通改动块分派，保留其他行级 Git 操作。
                -- 取消 ]h（下一个改动块）和 [h（上一个改动块），分别迁到 Alt-j/k。
                for old, new in pairs({ ["]h"] = "<A-j>", ["[h"] = "<A-k>" }) do
                    vim.api.nvim_buf_call(buf, function()
                        local mapping = vim.fn.maparg(old, "n", false, true)
                        if mapping.buffer == 1 then
                            vim.keymap.del("n", old, { buffer = buf })
                            if vim.bo[buf].buftype == "" then
                                vim.keymap.set(
                                    "n",
                                    new,
                                    mapping.callback or mapping.rhs,
                                    {
                                        buffer = buf,
                                        silent = true,
                                        desc = old == "]h"
                                                and "下一个 Git 改动块"
                                            or "上一个 Git 改动块",
                                    }
                                )
                            end
                        end
                    end)
                end
            end
        end,
    },
}
