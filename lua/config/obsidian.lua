local M = {}

function M.workspaces(root)
    local workspaces = {}
    local entries = vim.uv.fs_scandir(root)
    if not entries then
        return workspaces
    end

    while true do
        local name = vim.uv.fs_scandir_next(entries)
        if not name then
            break
        end
        local path = root .. "/" .. name
        local directory = vim.uv.fs_stat(path)
        local marker = vim.uv.fs_stat(path .. "/.obsidian")
        if
            name:sub(1, 1) ~= "."
            and directory
            and directory.type == "directory"
            and marker
            and marker.type == "directory"
        then
            workspaces[#workspaces + 1] = {
                name = name,
                path = path,
                strict = true,
            }
        end
    end

    table.sort(workspaces, function(a, b)
        return a.name < b.name
    end)
    return workspaces
end

return M
