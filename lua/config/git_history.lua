-- 将历史文件与当前编辑内容放进独立标签页比较，不 checkout、不改工作区。
local M = {}

function M.compare(picker, item)
    if not item or not item.commit or not item.cwd then
        return
    end
    local current = picker.finder.filter.current_buf
    if
        not vim.api.nvim_buf_is_valid(current)
        or not vim.api.nvim_buf_is_loaded(current)
    then
        vim.notify(
            "原文件缓冲区已关闭，请重新打开历史列表",
            vim.log.levels.WARN
        )
        return
    end
    local historical, historical_path
    -- Snacks 的文件历史条目包含 --follow 找到的旧路径，兼容文件改名。
    for _, file in ipairs(item.files or { item.file }) do
        local path = vim.fs.relpath(item.cwd, file) or file
        local result = vim.system(
            { "git", "--no-pager", "show", item.commit .. ":" .. path },
            {
                cwd = item.cwd,
            }
        ):wait(5000)
        if result.code == 0 then
            historical, historical_path = result.stdout, path
            break
        end
    end
    if not historical then
        vim.notify(
            "无法读取该提交中的文件版本，可能是删除记录或历史路径不存在",
            vim.log.levels.WARN
        )
        return
    end
    if historical:find("\0", 1, true) then
        vim.notify(
            "该历史版本为二进制文件，无法进行文本对比",
            vim.log.levels.WARN
        )
        return
    end
    local now = vim.api.nvim_buf_get_lines(current, 0, -1, false)
    local ft = vim.bo[current].filetype
    local old = vim.split(historical, "\n", { plain = true })
    if old[#old] == "" then
        table.remove(old)
    end
    if #old == 0 then
        old = { "" }
    end
    -- q 只绑定在两个快照上，不影响原编辑窗口的映射或 diff 选项。
    local function snapshot(label, lines)
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(buf, "git-history://" .. buf .. "/" .. label)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].filetype = ft
        vim.bo[buf].modifiable = false
        vim.bo[buf].readonly = true
        vim.keymap.set(
            "n",
            "q",
            "<cmd>tabclose<cr>",
            { buffer = buf, desc = "关闭历史对比" }
        )
        return buf
    end
    local before =
        snapshot(item.commit:sub(1, 8) .. "/" .. historical_path, old)
    local after = snapshot(
        "当前内容/"
            .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(current), ":t"),
        now
    )
    picker:close()
    vim.cmd.tabnew()
    vim.api.nvim_win_set_buf(0, before)
    vim.cmd.diffthis()
    vim.cmd("rightbelow vnew")
    vim.api.nvim_win_set_buf(0, after)
    vim.cmd.diffthis()
    vim.cmd.normal({ "gg", bang = true })
end

return M
