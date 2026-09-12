-- 状态栏的显示逻辑；开关状态及保存仍由 config.toggles 管理。
local M = {}

-- 颜色辅助：读取主题的实际前景色，缺失时回退到普通文本颜色。
local function hl(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function rgb(value)
    return value and string.format("#%06x", value)
end
function M.color(name)
    return rgb(hl(name).fg) or rgb(hl("Normal").fg) or "#808080"
end

function M.project()
    local root = LazyVim.root.get()
    local name = vim.fs.basename(root)
    return ((name ~= "" and name or root):gsub("%%", "%%%%"))
end

-- 优先显示项目内相对路径；超宽时省略中间目录，始终保留完整文件名。
function M.shorten(path, width)
    if vim.fn.strdisplaywidth(path) <= width then
        return path
    end
    -- 缩短绝对路径时保留根前缀，避免看起来像项目内的相对路径。
    local prefix = path:match("^%a:/")
        or path:match("^//")
        or path:match("^/")
        or ""
    local parts = vim.split(
        path:sub(#prefix + 1),
        "/",
        { plain = true, trimempty = true }
    )
    if #parts <= 1 then
        return path
    end
    local tail = parts[#parts]
    for i = #parts - 1, 2, -1 do
        local candidate = parts[i] .. "/" .. tail
        if
            vim.fn.strdisplaywidth(prefix .. parts[1] .. "/…/" .. candidate)
            > width
        then
            break
        end
        tail = candidate
    end
    local candidate = prefix .. parts[1] .. "/…/" .. tail
    return vim.fn.strdisplaywidth(candidate) <= width and candidate
        or prefix .. "…/" .. tail
end

function M.path()
    local name = vim.api.nvim_buf_get_name(0)
    local path = "[未命名]"
    if name ~= "" then
        local root = LazyVim.root.get():gsub("/+$", "") .. "/"
        path = vim.startswith(name, root) and name:sub(#root + 1)
            or vim.fn.fnamemodify(name, ":~")
        path = M.shorten(
            path,
            math.max(20, math.floor(vim.api.nvim_win_get_width(0) * 0.45))
        )
    end
    local flags = vim.bo.modified and " ●" or ""
    if vim.bo.readonly then
        flags = flags .. " "
    end
    if name ~= "" and vim.bo.buftype == "" then
        -- 无读取权限不等于文件不存在，只在明确不存在时标记新文件。
        local _, _, code = vim.uv.fs_stat(name)
        if code == "ENOENT" then
            flags = flags .. " [新文件]"
        end
    end
    -- 文件名中的百分号不能被当作 statusline 格式指令。
    return (path .. flags):gsub("%%", "%%%%")
end

function M.show_path()
    -- 点击非活动窗口的顶部路径时，读取被点击窗口，不改变当前焦点。
    local win = vim.fn.getmousepos().winid
    local buf = win ~= 0
            and vim.api.nvim_win_is_valid(win)
            and vim.api.nvim_win_get_buf(win)
        or vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(buf)
    vim.notify(
        path ~= "" and path or "[未命名]",
        vim.log.levels.INFO,
        { title = "完整文件路径" }
    )
end

-- LSP：显示当前文件连接数，点击查看原生健康检查。
function M.lsp()
    local count = #vim.lsp.get_clients({ bufnr = 0 })
    return " " .. (count > 0 and tostring(count) or "—")
end
function M.lsp_info()
    vim.cmd("checkhealth vim.lsp")
end

-- 文件属性：常见的 UTF-8、LF 留空，只提示需要注意的格式差异。
function M.indent()
    return (vim.bo.expandtab and "空格 " or "Tab ")
        .. (vim.bo.expandtab and vim.fn.shiftwidth() or vim.bo.tabstop)
end
function M.encoding()
    local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding
        or vim.o.encoding
    return encoding:lower() ~= "utf-8" and encoding:upper() or ""
end
function M.fileformat()
    return ({ dos = "CRLF", mac = "CR" })[vim.bo.fileformat] or ""
end

-- 选区统计：显示字符、整行或矩形可视选区跨越的行数。
function M.selection()
    local mode = vim.fn.mode()
    if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
        return ""
    end
    return "选中 "
        .. (math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1)
        .. " 行"
end
return M
