-- 在 LazyVim 默认自动命令之后加载，只保留个人规则和必要的覆盖。
-- 恢复光标位置、保存时创建目录等通用行为沿用 LazyVim 默认实现。

-- 复制高亮由 Yanky 提供，关闭重复效果；重复加载时允许该组已被删除。
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_highlight_yank")

-- TEN_ 标记个人规则；重新加载时清除同组旧规则，避免重复注册。
local group = vim.api.nvim_create_augroup("TEN_formatoptions", { clear = true })

-- 通用排版规则只在 options.lua 定义；这里读取全局默认值，避免取到
-- 当前文件已被 ftplugin 修改的局部值。
local formatoptions = vim.go.formatoptions
local function apply_formatoptions(buf)
    if not vim.api.nvim_buf_is_loaded(buf) then
        return
    end
    local bo = vim.bo[buf]
    -- 仅处理普通文件，跳过终端、帮助和不列入缓冲区列表的插件面板。
    if bo.buftype ~= "" or not bo.buflisted then
        return
    end
    local prose = bo.filetype == "markdown" or bo.filetype == "text"
    bo.formatoptions = formatoptions .. (prose and "t" or "")
end

-- 等本轮文件类型配置执行完，再应用偏好；按事件缓冲区设置，避免延迟
-- 执行时误改已切换到的文件。切回文件不重置，保留临时的 :setlocal 调整。
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(event)
        vim.schedule(function()
            apply_formatoptions(event.buf)
        end)
    end,
})

-- autocmds.lua 可能延迟加载，补处理此前已经打开的文件。
local existing_buffers = vim.api.nvim_list_bufs()
vim.schedule(function()
    for _, buf in ipairs(existing_buffers) do
        apply_formatoptions(buf)
    end
end)

-- 补充 LazyVim 的焦点/终端检查：切入文件或普通模式停下操作时，检查
-- 当前文件是否被外部工具修改。最多每秒检查一次，不强制重载未保存的修改。
local check_group =
    vim.api.nvim_create_augroup("TEN_checktime", { clear = true })
local last_check = -math.huge
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold" }, {
    group = check_group,
    callback = function(event)
        if
            event.buf ~= vim.api.nvim_get_current_buf()
            or vim.api.nvim_get_mode().mode ~= "n"
            or vim.fn.getcmdwintype() ~= ""
            or vim.bo[event.buf].buftype ~= ""
            or not vim.bo[event.buf].buflisted
            or vim.api.nvim_buf_get_name(event.buf) == ""
        then
            return
        end
        local now = vim.uv.hrtime() / 1e6
        if now - last_check < 1000 then
            return
        end
        last_check = now
        vim.cmd("checktime " .. event.buf)
    end,
})

-- 只在当前普通编辑窗口显示光标行，终端、浮窗及插件面板保留各自设置。
local cursor_group =
    vim.api.nvim_create_augroup("TEN_cursorline", { clear = true })
local function update_cursorline()
    local current = vim.api.nvim_get_current_win()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if
            vim.api.nvim_win_get_config(win).relative == ""
            and vim.bo[buf].buftype == ""
            and vim.bo[buf].buflisted
        then
            vim.wo[win].cursorline = win == current
        end
    end
end
vim.api.nvim_create_autocmd(
    { "WinEnter", "WinLeave", "BufWinEnter", "FileType" },
    {
        group = cursor_group,
        callback = function()
            -- 等窗口切换、文件类型插件的本轮设置结束，再按最终焦点更新。
            vim.schedule(update_cursorline)
        end,
    }
)
vim.schedule(update_cursorline)
