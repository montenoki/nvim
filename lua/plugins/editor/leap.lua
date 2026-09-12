return {
    {
        "https://codeberg.org/andyg/leap.nvim.git",
        -- 替换 Extra 的键位列表，避免为 s/S/gs 创建懒加载映射。
        keys = function()
            local keys = {
                {
                    "\\",
                    function()
                        require("leap").leap({
                            windows = require("leap.user").get_focusable_windows(),
                        })
                    end,
                    mode = { "n", "x", "o" },
                    desc = "Leap",
                },
            }
            for _, motion in ipairs({
                { "f", "Find forward", {} },
                { "F", "Find backward", { backward = true } },
                { "t", "Till forward", { offset = -1 } },
                { "T", "Till backward", { backward = true, offset = 1 } },
            }) do
                keys[#keys + 1] = {
                    motion[1],
                    function()
                        require("leap").leap(vim.tbl_deep_extend("keep", {
                            inputlen = 1,
                            inclusive = true,
                            opts = {
                                labels = "",
                                -- 保持 Flit 的 labeled_modes = "nx" 行为：仅普通和可视模式显示标签。
                                safe_labels = vim.fn.mode(1):match("o") and ""
                                    or nil,
                                case_sensitive = true,
                            },
                        }, motion[3]))
                    end,
                    mode = { "n", "x", "o" },
                    desc = motion[2],
                }
            end
            return keys
        end,
        opts = function(_, opts)
            -- 移除 Extra 仍在传入的 Flit 选项，Leap 不使用该选项。
            opts.labeled_modes = nil
        end,
        config = function(_, opts)
            for k, v in pairs(opts) do
                require("leap").opts[k] = v
            end
        end,
    },
}
