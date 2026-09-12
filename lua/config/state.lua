-- 只负责 JSON 读写，不解释字段、不操作编辑器；业务规则由调用者决定。
-- 使用可写的 state 目录，兼容只读 Nix 配置。
local M = {}

M.path = vim.fn.stdpath("state") .. "/preferences.json"

local function read()
    local ok, lines = pcall(vim.fn.readfile, M.path)
    if not ok then
        return {}
    end
    local decoded, value = pcall(vim.json.decode, table.concat(lines, "\n"))
    return decoded and type(value) == "table" and value or {}
end

function M.get(key)
    return read()[key]
end

function M.set(key, value)
    -- 写入前重新读取，保留其他模块或实例已保存的字段。
    -- 临时文件再重命名避免半写文件；这不是跨进程事务锁。
    local data = read()
    data[key] = value
    local temporary = M.path .. "." .. vim.fn.getpid() .. ".tmp"
    local ok, err = pcall(function()
        vim.fn.mkdir(vim.fn.fnamemodify(M.path, ":h"), "p")
        assert(vim.fn.writefile({ vim.json.encode(data) }, temporary) == 0)
        assert(vim.uv.fs_rename(temporary, M.path))
    end)
    if not ok then
        pcall(vim.fn.delete, temporary)
        vim.notify(
            "Could not save preferences: " .. tostring(err),
            vim.log.levels.WARN
        )
    end
    return ok
end

return M
