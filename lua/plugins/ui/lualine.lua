local display = require("config.ui.statusline")
local toggles = require("config.toggles")

-- 底栏只显示和接收点击，状态与保存交给开关模块。
local function toggle_component(key, icon)
    return {
        function()
            return icon
        end,
        color = function()
            -- 开启时继承所在色块的前景色，避免强调色与色块背景重合。
            return toggles.enabled(key) and {}
                or { fg = display.color("Comment") }
        end,
        on_click = function()
            toggles.toggle(key)
        end,
        padding = { left = 0, right = 1 },
    }
end

return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
        -- 使用主题自带的 a/z、b/y、c/x 三层色块，不再统一背景。
        opts.options.theme = "auto"
        opts.options.disabled_filetypes.winbar = { "dap-repl" }
        opts.options.component_separators = { left = "", right = "" }
        opts.options.section_separators = { left = "", right = "" }

        -- 继承录制、调试及更新提示，把默认 Git 统计移到顶部。
        -- LazyVim 默认 x 栏第 2 项是 Noice showcmd（未完成的按键组合），不再显示。
        local diff
        local status = {}
        for index, component in ipairs(opts.sections.lualine_x) do
            if type(component) == "table" and component[1] == "diff" then
                diff = component
            elseif index ~= 2 then
                status[#status + 1] = component
            end
        end
        opts.sections.lualine_a = { { "mode", icon = "" } }
        opts.sections.lualine_b =
            { { display.project, icon = "󱉭" }, { "branch", icon = "" } }
        -- 左侧由外向内：模式 → 项目/分支/环境 → 临时运行提示。
        opts.sections.lualine_c = status
        -- 右侧由内向外：选区/特殊格式 → LSP → 文件属性/位置 → 全局开关。
        opts.sections.lualine_x = {
            { display.selection },
            { display.encoding },
            { display.fileformat },
            {
                display.lsp,
                color = function()
                    return {
                        fg = display.color(
                            #vim.lsp.get_clients({ bufnr = 0 }) == 0
                                    and "Comment"
                                or "Function"
                        ),
                    }
                end,
                on_click = display.lsp_info,
            },
        }
        -- 保留默认位置组件，前面放文件属性；行列号最靠近固定开关。
        local position = opts.sections.lualine_y
        opts.sections.lualine_y = {
            { "filetype", colored = false },
            { display.indent },
        }
        vim.list_extend(opts.sections.lualine_y, position or {})
        -- 开关固定在最右端，便于形成点击习惯。
        opts.sections.lualine_z = {
            toggle_component("diagnostics", ""),
            toggle_component("inlay_hints", "󰓽"),
            toggle_component("codelens", ""),
            toggle_component("conceal", "󰦦"),
            toggle_component("spell", ""),
            toggle_component("list", "󰀫"),
            toggle_component("relativenumber", ""),
            toggle_component("autoformat", "󰁨"),
            toggle_component("showkeys", "󰌌"),
        }
        -- 顶部同样两端稳定：左侧文件路径，右侧诊断，符号路径与 Git 变化靠中间。
        local path = { display.path, on_click = display.show_path }
        opts.winbar = {
            lualine_b = { vim.deepcopy(path) },
            lualine_c = {}, -- navic.lua 在这里追加符号路径。
            lualine_x = diff and { diff } or {},
            lualine_y = { "diagnostics" },
        }
        opts.inactive_winbar = { lualine_c = { vim.deepcopy(path) } }
    end,
}
