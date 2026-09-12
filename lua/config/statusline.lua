-- 状态栏的显示逻辑；开关状态及保存仍由 config.toggles 管理。
local M = {}
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
    return (vim.fs.basename(LazyVim.root.get()):gsub("%%", "%%%%"))
end

-- 优先显示项目内相对路径；超宽时省略中间目录，始终保留完整文件名。
function M.shorten(path, width)
    if vim.fn.strdisplaywidth(path) <= width then
        return path
    end
    local parts = vim.split(path, "/", { plain = true, trimempty = true })
    if #parts <= 1 then
        return path
    end
    local tail = parts[#parts]
    for i = #parts - 1, 2, -1 do
        local candidate = parts[i] .. "/" .. tail
        if vim.fn.strdisplaywidth(parts[1] .. "/…/" .. candidate) > width then
            break
        end
        tail = candidate
    end
    local candidate = parts[1] .. "/…/" .. tail
    return vim.fn.strdisplaywidth(candidate) <= width and candidate
        or "…/" .. tail
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
    if
        name ~= ""
        and vim.bo.buftype == ""
        and vim.fn.filereadable(name) == 0
    then
        flags = flags .. " [新文件]"
    end
    -- 文件名中的百分号不能被当作 statusline 格式指令。
    return (path .. flags):gsub("%%", "%%%%")
end

function M.show_path()
    local path = vim.api.nvim_buf_get_name(0)
    vim.notify(
        path ~= "" and path or "[未命名]",
        vim.log.levels.INFO,
        { title = "完整文件路径" }
    )
end

function M.lsp()
    local count = #vim.lsp.get_clients({ bufnr = 0 })
    return " " .. (count > 0 and tostring(count) or "—")
end
function M.lsp_info()
    vim.cmd("checkhealth vim.lsp")
end
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
