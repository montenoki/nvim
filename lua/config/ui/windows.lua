-- 功能窗口的显示名称与文件打开目标共用一份分类，不改写插件的 buffer 名称。
local M = {}

local names = {
    ["neo-tree"] = "文件树",
    ["neo-tree-popup"] = "文件树操作",
    lazy = "插件管理",
    mason = "开发工具管理",
    noice = "消息",
    notify = "通知",
    snacks_notif = "通知",
    snacks_notif_history = "通知历史",
    snacks_dashboard = "欢迎",
    snacks_terminal = "终端",
    snacks_input = "输入",
    snacks_win_help = "窗口帮助",
    snacks_picker_input = "搜索输入",
    snacks_picker_list = "搜索结果",
    snacks_picker_preview = "搜索预览",
    fzf = "搜索",
    TelescopePrompt = "搜索输入",
    TelescopeResults = "搜索结果",
    TelescopePreview = "搜索预览",
    ["grug-far"] = "搜索与替换",
    ["grug-far-history"] = "替换历史",
    ["grug-far-help"] = "替换帮助",
    Avante = "AI 对话",
    AvanteInput = "AI 输入",
    AvantePromptInput = "AI 编辑指令",
    AvanteSelectedCode = "AI 选中代码",
    AvanteSelectedFiles = "AI 上下文文件",
    AvanteTodos = "AI 任务",
    AvanteConfirm = "AI 操作确认",
    NeogitStatus = "Git 状态",
    NeogitLogView = "Git 提交历史",
    NeogitCommitView = "Git 提交详情",
    NeogitCommitSelectView = "Git 提交选择",
    NeogitDiffView = "Git 差异",
    NeogitRefsView = "Git 引用",
    NeogitReflogView = "Git 引用历史",
    NeogitStashView = "Git 暂存记录",
    NeogitConsole = "Git 命令输出",
    NeogitGitCommandHistory = "Git 命令历史",
    NeogitPopup = "Git 操作",
    help = "帮助",
    man = "Man 手册",
    checkhealth = "健康检查",
    ["which-key"] = "快捷键提示",
}

local trouble_modes = {
    diagnostics = "诊断列表",
    symbols = "符号树",
    lsp = "LSP 导航",
    lsp_document_symbols = "符号树",
    lsp_references = "引用",
    lsp_definitions = "定义",
    lsp_declarations = "声明",
    lsp_implementations = "实现",
    lsp_type_definitions = "类型定义",
    qflist = "Quickfix 列表",
    loclist = "位置列表",
    todo = "待办事项",
    telescope = "搜索结果",
}

function M.name(win)
    win = win and win ~= 0 and win or vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(win)
    local ft, bt = vim.bo[buf].filetype, vim.bo[buf].buftype
    if ft:lower() == "trouble" then
        local mode = (vim.w[win].trouble or {}).mode
        return (trouble_modes[mode] or mode or "问题列表")
            .. "（Trouble）"
    end
    if ft == "qf" then
        local info = vim.fn.getwininfo(win)[1]
        return info and info.loclist == 1 and "位置列表"
            or "Quickfix 列表"
    end
    if names[ft] then
        return names[ft]
    end
    -- 插件新增的面板也保留可识别的名称，不落到“未命名”。
    for prefix, label in pairs({
        Avante = "AI 面板",
        Neogit = "Git 面板",
        snacks_ = "工具面板",
        Telescope = "搜索面板",
    }) do
        if vim.startswith(ft, prefix) then
            return label .. "（" .. ft .. "）"
        end
    end
    if bt == "terminal" then
        return "终端"
    end
    if bt ~= "" and bt ~= "acwrite" then
        return ft ~= "" and ("工具窗口（" .. ft .. "）") or "工具窗口"
    end
end

-- 显示名称不等于禁止打开文件：启动页是可以被文件替换的占位窗口。
function M.is_open_target(win)
    local config = vim.api.nvim_win_get_config(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return config.relative == ""
        and not config.external
        and not vim.wo[win].previewwindow
        and not vim.wo[win].winfixbuf
        and (vim.bo[buf].filetype == "snacks_dashboard" or M.name(win) == nil)
end

-- 保留上游过滤规则，再筛选文件或启动页等可被文件替换的窗口。
function M.filter(windows, rules)
    local filter = require("window-picker.filters.default-window-filter"):new()
    filter:set_config(rules)
    return vim.tbl_filter(M.is_open_target, filter:filter_windows(windows))
end

return M
