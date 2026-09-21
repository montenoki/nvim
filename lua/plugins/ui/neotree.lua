return {
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        -- 用悬浮大字母标记可选窗口，快捷键和 Neo-tree 共用此设置。
        opts = {
            hint = "floating-big-letter",
            filter_func = require("config.ui.windows").filter,
        },
        keys = {
            {
                "<leader>wp",
                function()
                    local picked_window_id =
                        require("window-picker").pick_window()
                    if picked_window_id then
                        vim.api.nvim_set_current_win(picked_window_id)
                    end
                end,
                desc = "选择窗口",
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        keys = {
            { "<leader>fe", false }, -- 打开项目根目录文件树；统一到 e 的 cwd 范围。
            { "<leader>fE", false }, -- 打开 cwd 文件树；统一到 e。
            { "<leader>E", false }, -- cwd 文件树的 fE 别名；统一到 e。
            { "<leader>ge", false }, -- 打开 Git 状态文件树；交给 Neogit/Lazygit。
            { "<leader>be", false }, -- 打开树状缓冲区列表；取消侧边列表入口。
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({
                        source = "filesystem",
                        toggle = true,
                        dir = vim.fn.getcwd(),
                    })
                end,
                desc = "资源管理器",
            },
        },
        opts = function(_, inherited)
            local defaults = require("neo-tree.defaults")
            -- 排序属于各 source 的局部映射，必须一起迁移整个前缀。
            for _, source in ipairs({ "filesystem", "buffers", "git_status" }) do
                inherited[source] = inherited[source] or {}
                inherited[source].window = inherited[source].window or {}
                local mappings = inherited[source].window.mappings or {}
                inherited[source].window.mappings = mappings
                local original = vim.tbl_extend(
                    "force",
                    defaults[source].window.mappings,
                    mappings
                )
                for key, action in pairs(original) do
                    if key:match("^o") then
                        mappings[key] = "none"
                        local target = "O" .. key:sub(2)
                        mappings[target] = vim.deepcopy(action)
                        if key == "o" then
                            mappings[target].config.prefix_key = "O"
                            mappings[target].config.title = "排序"
                        end
                    end
                end
                mappings.o = vim.deepcopy(inherited.window.mappings.O)
                mappings.o.desc = "使用系统程序打开"
            end
            inherited.window.mappings.O = nil
            return vim.tbl_deep_extend("force", inherited, {
                filesystem = {
                    filtered_items = {
                        -- 默认显示点文件，只隐藏 Git 忽略的文件。
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_ignored = false,
                    },
                },
                event_handlers = {
                    {
                        event = "file_open_requested",
                        handler = function(data)
                            if
                                data.open_cmd ~= "edit"
                                and data.open_cmd ~= "split"
                                and data.open_cmd ~= "vsplit"
                            then
                                return
                            end
                            local windows = require("config.ui.windows")
                            for _, win in
                                ipairs(vim.api.nvim_tabpage_list_wins(0))
                            do
                                if windows.is_open_target(win) then
                                    return -- 有编辑窗口或启动页时交给选择器，保留取消操作。
                                end
                            end
                            -- 只剩文件树或其他功能面板时，新建编辑窗口接收文件。
                            -- 直接打开，避免先建空窗口再 split 导致多余分屏。
                            vim.api.nvim_cmd({
                                cmd = data.open_cmd == "split" and "new"
                                    or "vnew",
                                args = { data.path },
                                mods = { split = "botright" },
                            }, {})
                            return { handled = true }
                        end,
                    },
                    {
                        event = "file_opened",
                        handler = function()
                            -- 从目录树打开文件后，自动收起目录树。
                            require("neo-tree.command").execute({
                                action = "close",
                            })
                        end,
                    },
                },
                window = {
                    mappings = {
                        ["w"] = "none", -- 选择窗口并打开文件；统一到 Enter。
                        -- 先选择目标窗口，再打开文件或创建分屏。
                        ["v"] = {
                            "vsplit_with_window_picker",
                            desc = "选择窗口并垂直分屏",
                        },
                        ["s"] = {
                            "split_with_window_picker",
                            desc = "选择窗口并水平分屏",
                        },
                        ["S"] = "none", -- 直接水平分屏打开；使用 s 选择窗口后分屏。
                        -- 与上游默认键名保持一致，避免 <CR>/<cr> 并存后相互覆盖。
                        ["<cr>"] = {
                            "open_with_window_picker",
                            desc = "选择窗口并打开文件",
                        },
                    },
                },
                default_component_configs = {
                    git_status = {
                        symbols = {
                            -- 自定义变更图标，其余沿用默认值。
                            added = "",
                            deleted = "",
                            modified = "",
                            renamed = "",
                            -- 暂存状态图标：staged 特意覆盖 LazyVim 的默认设置。
                            unstaged = "󰢤",
                            staged = "",
                        },
                    },
                },
            })
        end,
    },
}
