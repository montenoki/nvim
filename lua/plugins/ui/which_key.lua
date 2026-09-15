local describe = require("config.ui.key_descriptions")

return {
    {
        "folke/which-key.nvim",
        keys = function(_, keys)
            -- 取消 Ctrl-w Space：原为可连续执行窗口操作的 Which-key 提示入口。
            keys = vim.tbl_filter(function(key)
                return key[1] ~= "<c-w><space>"
            end, keys)
            -- 直接修改继承条目的 desc，保留函数；仅追加同名键会覆盖原动作。
            for _, key in ipairs(keys) do
                if type(key.desc) == "string" then
                    key.desc = describe(key.desc)
                end
            end
            return keys
        end,
        opts = function(_, opts)
            -- 按前缀补齐分组图标，避免中文名称无法匹配上游英文图标规则。
            local group_icons = {
                ["<leader>b"] = { icon = "󰓩", color = "cyan" },
                ["<leader>c"] = { icon = "", color = "blue" },
                ["<leader>f"] = { icon = "", color = "yellow" },
                ["<leader>g"] = { icon = "", color = "orange" },
                ["<leader>gh"] = { icon = "", color = "orange" },
                ["<leader>q"] = { icon = "󰍡", color = "purple" },
                ["<leader>u"] = { icon = "", color = "cyan" },
                ["<leader>w"] = { icon = "", color = "blue" },
                ["<leader>x"] = { icon = "", color = "yellow" },
                ["["] = { icon = "", color = "cyan" },
                ["]"] = { icon = "", color = "cyan" },
                g = { icon = "󰁔", color = "green" },
                gz = { icon = "󰅩", color = "orange" },
                z = { icon = "󰘖", color = "purple" },
            }
            -- 就地翻译继承的分组，保留 buffer 的 expand 和 windows 的 proxy。
            -- 不重复声明同一组，避免覆盖动态列表或产生重复分组警告。
            local function translate_groups(spec)
                -- 删除已取消入口的分组，包括调试和性能分析。
                for i = #spec, 1, -1 do
                    if
                        type(spec[i]) == "table"
                        and (
                            spec[i][1] == "<leader><tab>"
                            or spec[i][1] == "<leader>d"
                            or spec[i][1] == "<leader>dp"
                            or spec[i][1] == "<leader>s"
                            or spec[i][1] == "<leader>sn"
                        )
                    then
                        table.remove(spec, i)
                    end
                end
                -- Leap Extra 已把 mini.surround 从 gs 移到 gz，菜单跟随实际前缀。
                if spec[1] == "gs" and spec.group == "surround" then
                    spec[1] = "gz"
                end
                if type(spec.group) == "string" then
                    spec.group = describe(spec.group)
                    if spec.icon == nil then
                        spec.icon = group_icons[spec[1]]
                    end
                end
                for _, child in ipairs(spec) do
                    if type(child) == "table" then
                        translate_groups(child)
                    end
                end
            end
            opts.spec = opts.spec or {}
            translate_groups(opts.spec)
            -- 单项图标只作为菜单元数据，不覆盖插件注册的实际动作。
            local entry_icons = {
                { "<leader>xq", "" },
                { "<leader>gb", "" },
                { "<leader>gf", "" },
                { "<leader>gg", "" },
                { "<leader>gn", "" },
                { "<leader>go", "" },
                { "<leader>gy", "" },
                { "<leader>fb", "󰓩" },
                { "<leader>fl", "" },
                { "<leader>fn", "" },
                { "<leader>fr", "" },
                { "<leader>fy", "↳" },
                { "<leader>fY", "" },
                { "<leader>bd", "󰅖" }, -- 关闭当前缓冲区。
                { "<leader>bo", "󰆴" }, -- 清理其他缓冲区。
                { "<leader>bp", "" }, -- 按字母选择缓冲区。
                { "<leader>k", "󰌷" },
                { "<leader>m", "⚑" },
                { "<leader>n", "" },
                { "<leader>o", "" },
                { "<leader>p", "" },
                { "<leader>P", "🗒" },
                { "<leader>r", "" },
                { '<leader>"', "󰨸" },
                { "<leader>:", "" },
                { "<leader><space>", "󰈞" },
                { "<leader>qr", "" },
                { "<leader>qs", "" },
            }
            for _, entry in ipairs(entry_icons) do
                opts.spec[#opts.spec + 1] = {
                    entry[1],
                    mode = "n",
                    icon = { icon = entry[2], color = "cyan" },
                }
            end
            vim.list_extend(opts.spec, {
                -- 代码动作图标；仅提供菜单元数据，实际入口仍由 LSP/语言配置决定。
                { "<leader>ca", mode = { "n", "x" }, icon = "" },
                { "<leader>cc", mode = { "n", "x" }, icon = "" },
                { "<leader>cf", mode = { "n", "x" }, icon = "" },
                { "<leader>cF", mode = { "n", "x" }, icon = "" },
                { "<leader>co", mode = "n", icon = "" },
                { "<leader>cr", mode = "n", icon = "󰑕" },
                { "<leader>cz", mode = { "n", "x" }, icon = "󰗊" },
                { "<leader>cv", mode = "n", icon = "" },
                { "<leader>cR", mode = "n", icon = "" },
                -- AI 动作使用独立图标，模式跟随各动作的实际映射。
                { "<leader>aa", mode = { "n", "v" }, icon = "󰭻" },
                { "<leader>aB", mode = "n", icon = "" },
                { "<leader>ac", mode = "n", icon = "" },
                { "<leader>ah", mode = "n", icon = "" },
                { "<leader>am", mode = "n", icon = "" },
                { "<leader>an", mode = { "n", "v" }, icon = "" },
                { "<leader>aS", mode = "n", icon = "" },
                -- 图标属于 Which-key 菜单元数据，不能放入 lazy.nvim 的 keys 映射选项。
                {
                    "<leader>?",
                    mode = "n",
                    icon = { icon = "", color = "cyan" },
                },
                -- Avante 的上游映射使用 v，同时覆盖 Visual 和 Select 模式。
                {
                    "<leader>a",
                    mode = { "n", "v" },
                    group = "AI 助手",
                    icon = { icon = "󰧑", color = "blue" },
                },
                {
                    "<leader>t",
                    group = "任务",
                    mode = "n",
                    icon = { icon = "", color = "green" },
                },
                {
                    "<leader>h",
                    group = "历史",
                    mode = { "n", "x" },
                    icon = { icon = "", color = "purple" },
                },
            })
            -- 图标条目只修饰实际存在的映射，避免显示尚未挂载的 LSP/语言功能。
            for _, spec in ipairs(opts.spec) do
                if spec.icon and not spec.group and spec[2] == nil then
                    spec.real = true
                end
            end
        end,
        config = function(_, opts)
            require("which-key").setup(opts)
            -- setup 合并完默认清理规则（如去掉 +、<Cmd>）后，追加完整描述翻译。
            -- 不创建映射；保留上游及个人已有的 replace 规则。
            table.insert(
                require("which-key.config").options.replace.desc,
                describe
            )
        end,
    },
}
