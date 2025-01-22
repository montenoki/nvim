local default_config = {
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    -- workspaces = {
    --     {
    --         name = "default",
    --         path = "~/vaults/default",
    --     },
    -- },
}

-- 尝试加载本地配置
local function load_local_config()
    local local_config_path = vim.fn.stdpath("config")
        .. "/lua/local/obsidian.lua"
    local ok, local_config = pcall(dofile, local_config_path)
    if ok then
        return local_config
    else
        -- 返回默认配置
        return default_config
    end
end

local M = {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}
local config = load_local_config()

if config.event ~= nil then
    M.event = config.event
end
if config.opt ~= nil then
    M.opt = config.opt
end

return M
