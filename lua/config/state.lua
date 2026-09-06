-- Runtime preferences live outside the config (which may be in the Nix store).
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
    -- Re-read so unrelated preferences written by another instance survive.
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
