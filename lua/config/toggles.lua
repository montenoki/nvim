-- 统一管理开关的状态读取、全局应用和保存；底栏与快捷键共用此模块。
-- 不监听任意 :set，避免把插件默认值误存为用户偏好。
local M = {}
local state = require("config.state")
local values = {}
local options = {
    conceal = "conceallevel",
    spell = "spell",
    list = "list",
    relativenumber = "relativenumber",
}
local keys = {
    "diagnostics", -- 诊断
    "inlay_hints", -- 行内提示
    "codelens", -- CodeLens
    "conceal", -- 文本隐藏
    "spell", -- 拼写检查
    "list", -- 空白字符
    "relativenumber", -- 相对行号
    "autoformat", -- 自动格式化
    "showkeys", -- 按键浮窗
}
local started = false

local function restore_window(win)
    if not vim.api.nvim_win_is_valid(win) then
        return
    end
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype ~= "" then
        return
    end
    for key, option in pairs(options) do
        if values[key] ~= nil then
            vim.wo[win][option] = key == "conceal" and (values[key] and 2 or 0)
                or values[key]
        end
    end
end

local function lenses(buf)
    if vim.lsp.codelens.enable then
        return -- Neovim 0.12 自行管理刷新。
    end
    -- 兼容没有 codelens.enable 的旧版 Neovim。
    if values.codelens then
        ---@diagnostic disable-next-line: deprecated
        vim.lsp.codelens.refresh({ bufnr = buf })
    elseif values.codelens == false then
        ---@diagnostic disable-next-line: deprecated
        vim.lsp.codelens.clear(nil, buf)
    end
end

local function apply(key, enabled)
    if options[key] then
        vim.opt_global[options[key]] = key == "conceal" and (enabled and 2 or 0)
            or enabled
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            restore_window(win)
        end
    elseif key == "diagnostics" then
        vim.diagnostic.enable(enabled)
    elseif key == "inlay_hints" then
        vim.lsp.inlay_hint.enable(enabled)
    elseif key == "codelens" then
        if vim.lsp.codelens.enable then
            vim.lsp.codelens.enable(enabled)
        else
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    lenses(buf)
                end
            end
        end
    elseif key == "showkeys" then
        -- options.lua 恢复状态时插件尚未加载，只记住选择，稍后再应用。
        local plugin = package.loaded["showkeys"]
        if
            plugin
            and (require("showkeys.state").visible == true) ~= enabled
        then
            plugin[enabled and "open" or "close"]()
        end
    elseif key == "autoformat" then
        vim.g.autoformat = enabled
        -- 清除旧的文件级覆盖，让全局选择对已打开的文件同样生效。
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            vim.b[buf].autoformat = nil
        end
    end
end

function M.enabled(key)
    if options[key] then
        local value = vim.wo[options[key]]
        return key == "conceal" and value > 0 or (key ~= "conceal" and value)
    elseif key == "diagnostics" then
        return vim.diagnostic.is_enabled()
    elseif key == "inlay_hints" then
        return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    elseif key == "codelens" then
        if vim.lsp.codelens.is_enabled then
            return vim.lsp.codelens.is_enabled()
        end
        return values.codelens == true
    elseif key == "showkeys" then
        local plugin_state = package.loaded["showkeys.state"]
        if plugin_state then
            return plugin_state.visible == true
        end
        return values.showkeys == true
    elseif key == "autoformat" then
        if vim.b.autoformat ~= nil then
            return vim.b.autoformat
        end
        return vim.g.autoformat ~= false
    end
    error("Unknown toggle: " .. key)
end

-- 主动设置才保存；启动恢复只应用，避免重复写盘。
function M.set(key, enabled)
    M.enabled(key) -- 校验名称。
    assert(type(enabled) == "boolean", "Toggle value must be boolean")
    if key == "showkeys" and not package.loaded["showkeys"] then
        require("lazy").load({ plugins = { "showkeys" } })
    end
    values[key] = enabled
    apply(key, enabled)
    state.set("toggle." .. key, enabled)
    vim.notify(
        key .. (enabled and " on" or " off"),
        vim.log.levels.INFO,
        { title = "Toggle" }
    )
end

function M.toggle(key)
    M.set(key, not M.enabled(key))
end

-- 在 LazyVim 默认映射之后绑定；格式化只保留全局入口。
function M.map_keys()
    local mappings = {
        { "<leader>ud", "diagnostics", "诊断" },
        { "<leader>uh", "inlay_hints", "行内提示" },
        { "<leader>uc", "conceal", "文本隐藏" },
        { "<leader>us", "spell", "拼写检查" },
        { "<leader>uL", "relativenumber", "相对行号" },
        { "<leader>uf", "autoformat", "自动格式化" },
    }
    for _, mapping in ipairs(mappings) do
        local key = mapping[2]
        vim.keymap.set("n", mapping[1], function()
            M.toggle(key)
        end, { desc = "切换" .. mapping[3] .. "（记住选择）" })
    end
end

function M.setup()
    if started then
        return
    end
    started = true
    for _, key in ipairs(keys) do
        local saved = state.get("toggle." .. key)
        if type(saved) == "boolean" then
            values[key] = saved
            apply(key, saved)
        end
    end
    local group =
        vim.api.nvim_create_augroup("TEN_toggle_preferences", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "FileType" }, {
        group = group,
        callback = function()
            -- 等文件类型插件应用默认值后，再恢复已保存的偏好。
            vim.schedule(function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    restore_window(win)
                end
            end)
        end,
    })
    if not vim.lsp.codelens.enable then
        vim.api.nvim_create_autocmd(
            { "BufEnter", "CursorHold", "InsertLeave" },
            {
                group = group,
                callback = function(event)
                    lenses(event.buf)
                end,
            }
        )
    end
end

-- 首次默认关闭；恢复开关不写盘，也不会把超时隐藏误认为用户关闭。
function M.restore_showkeys()
    apply("showkeys", values.showkeys == true)
end

function M.configure_lsp(opts)
    local hints = vim.deepcopy(
        opts.inlay_hints or { enabled = true, exclude = { "vue" } }
    )
    local codelens = vim.deepcopy(opts.codelens or { enabled = false })
    -- 接管 LazyVim 自动启用逻辑，避免 LSP 晚连接时覆盖用户选择。
    opts.inlay_hints = vim.tbl_extend("force", hints, { enabled = false })
    opts.codelens = vim.tbl_extend("force", codelens, { enabled = false })
    if values.codelens == nil then
        values.codelens = codelens.enabled == true
        apply("codelens", values.codelens)
    end
    Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buf)
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" then
            local enabled = values.inlay_hints
            if enabled == nil then
                enabled = hints.enabled
                    and not vim.tbl_contains(
                        hints.exclude or {},
                        vim.bo[buf].filetype
                    )
            end
            vim.lsp.inlay_hint.enable(enabled, { bufnr = buf })
        end
    end)
    if not vim.lsp.codelens.enable then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, lenses)
    end
end

return M
