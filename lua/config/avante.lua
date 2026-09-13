-- Avante 的偏好适配；JSON 文件读写仍由 config.state 负责。
local M = {}
local state = require("config.state")

local function valid(choice, providers)
    return type(choice) == "table"
        and type(choice.model) == "string"
        and choice.model ~= ""
        and type(choice.provider) == "string"
        and type(providers[choice.provider]) == "table"
        and not providers[choice.provider].hide_in_model_selector
end

function M.setup(opts)
    local config = require("avante.config")
    local providers =
        vim.tbl_deep_extend("force", config._defaults.providers, opts.providers)
    local choice = state.get("avante.chat")
    -- 只在尚无统一偏好时迁移旧选择；保留旧文件，不再让上游读写它。
    if choice == nil then
        local path = vim.fn.stdpath("state") .. "/avante/config.json"
        if vim.fn.filereadable(path) == 1 then
            local ok, old = pcall(function()
                return vim.json.decode(
                    table.concat(vim.fn.readfile(path), "\n")
                )
            end)
            if ok and type(old) == "table" then
                local migrated =
                    { provider = old.last_provider, model = old.last_model }
                if valid(migrated, providers) then
                    choice = migrated
                    state.set("avante.chat", choice)
                end
            end
        end
    end
    if valid(choice, providers) then
        opts.provider = choice.provider
        opts.providers[choice.provider] = vim.tbl_extend(
            "force",
            providers[choice.provider],
            { model = choice.model }
        )
    elseif choice ~= nil then
        vim.notify(
            "已保存的 AI 提供方或模型格式无效，使用配置默认值",
            vim.log.levels.WARN
        )
    end
    -- 当前上游仅提供这两个存储函数；适配其接口，不修改插件源码。
    config.get_last_used_model = function() end
    config.save_last_model = function(model, provider)
        local selected =
            { model = model, provider = provider or config.provider }
        if valid(selected, config.providers) then
            return state.set("avante.chat", selected)
        end
        return false
    end
    local selection = state.get("toggle.ai_selection")
    local suggestion = state.get("toggle.ai_suggestion")
    opts.selection = vim.tbl_extend("force", opts.selection or {}, {
        enabled = type(selection) ~= "boolean" or selection,
    })
    opts.behaviour.auto_suggestions = suggestion == true
    require("avante").setup(opts)
end

function M.enabled(key)
    local config = package.loaded["avante.config"]
    if config and config._options then
        return key == "ai_selection" and config.selection.enabled
            or (key == "ai_suggestion" and config.behaviour.auto_suggestions)
    end
    local saved = state.get("toggle." .. key)
    if type(saved) == "boolean" then
        return saved
    end
    return key == "ai_selection"
end

function M.apply(key, enabled)
    if not package.loaded["avante"] then
        return
    end
    if M.enabled(key) ~= enabled then
        local avante = require("avante")
        avante.toggle[key == "ai_selection" and "selection" or "suggestion"]()
    end
end

return M
