-- 只负责发现笔记库，供 Obsidian 工作区配置和 Marksman 排除规则共用。
-- 每次调用重新扫描；插件工作区列表在配置加载时确定，新增、删除或迁移库后需重启。
local M = {}

-- 只扫描 root 的直接子目录：非隐藏目录中存在 .obsidian 目录才算笔记库。
-- 不递归、不将普通 Markdown 目录当作笔记库；符号链接按其实际目标判断。
---@param root string 笔记库的父目录
---@return {name: string, path: string, strict: boolean}[]
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
        -- 隐藏项提前跳过，不再对其执行文件检查。
        if name:sub(1, 1) ~= "." then
            local path = vim.fs.joinpath(root, name)
            local directory = vim.uv.fs_stat(path)
            if directory and directory.type == "directory" then
                local marker =
                    vim.uv.fs_stat(vim.fs.joinpath(path, ".obsidian"))
                if marker and marker.type == "directory" then
                    workspaces[#workspaces + 1] = {
                        name = name,
                        path = path,
                        -- 固定此目录为库根目录，不让插件另行向上查找。
                        strict = true,
                    }
                end
            end
        end
    end

    -- 保持工作区选择列表顺序稳定，不依赖文件系统的扫描顺序。
    table.sort(workspaces, function(a, b)
        return a.name < b.name
    end)
    return workspaces
end

return M
