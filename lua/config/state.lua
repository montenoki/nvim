-- 只负责 JSON 读写和失败提示，不解释字段、不应用开关；业务规则由调用者决定。
-- 使用可写的 state 目录，兼容只读 Nix 配置。
local M = {}

M.path = vim.fn.stdpath("state") .. "/preferences.json"
local last_read_error

local function warn(message)
    vim.notify(
        message .. "\n" .. M.path,
        vim.log.levels.WARN,
        { title = "偏好设置" }
    )
end

local function read()
    local ok, lines = pcall(vim.fn.readfile, M.path)
    if not ok or type(lines) ~= "table" then
        local _, _, code = vim.uv.fs_stat(M.path)
        if code == "ENOENT" then
            return {} -- 首次使用，没有状态文件属于正常情况。
        end
        return nil, "无法读取状态文件：" .. tostring(lines)
    end
    local contents = table.concat(lines, "\n")
    local decoded, value = pcall(vim.json.decode, contents)
    if not decoded then
        return nil, "状态文件 JSON 损坏：" .. tostring(value)
    end
    if type(value) ~= "table" or not contents:match("^%s*{") then
        return nil, "状态文件必须是 JSON 对象"
    end
    return value
end

function M.get(key)
    local data, err = read()
    if not data then
        -- 启动时会连续读取多个开关，同一异常只提示一次；修复后恢复正常读取。
        local signature = M.path .. "\n" .. err
        if last_read_error ~= signature then
            warn(err .. "\n本次使用默认值，原文件保留。")
            last_read_error = signature
        end
        return nil
    end
    last_read_error = nil
    return data[key]
end

function M.set(key, value)
    -- 写入前重新读取，保留其他模块或实例已保存的字段。
    -- 临时文件再重命名避免半写文件；这不是跨进程事务锁。
    local data, read_error = read()
    if not data then
        warn(
            read_error
                .. "\n已停止保存，原文件保留；修复文件后可重试。"
        )
        return false
    end
    last_read_error = nil
    data[key] = value
    local temporary = M.path .. "." .. vim.fn.getpid() .. ".tmp"
    local ok, err = pcall(function()
        vim.fn.mkdir(vim.fn.fnamemodify(M.path, ":h"), "p")
        assert(vim.fn.writefile({ vim.json.encode(data) }, temporary) == 0)
        assert(vim.uv.fs_rename(temporary, M.path))
    end)
    if not ok then
        pcall(vim.fn.delete, temporary)
        warn("无法保存偏好设置：" .. tostring(err))
    end
    return ok
end

return M
