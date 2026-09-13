-- 使用独立 XDG_STATE_HOME 连续运行 write/read 两阶段，验证真实重启恢复。
-- 不进入插入模式、不发送模型请求；不读取密钥。
require("lazy").load({ plugins = { "avante.nvim" } })
local config = require("avante.config")
local state = require("config.state")
local toggles = require("config.toggles")
local provider = "openrouter_suggestions"
local suggestion_model = "deepseek/deepseek-v4.1-flash"
assert(config.auto_suggestions_provider == provider)
assert(config.providers[provider].model == suggestion_model)
assert(config.providers[provider].hide_in_model_selector)
assert(config.behaviour.auto_set_keymaps == false)
local phase =
    assert(vim.env.NVIM_TEST_PHASE, "NVIM_TEST_PHASE must be write/read")
if phase == "write" then
    assert(config.provider == "openrouter")
    assert(config.providers.openrouter.model == "anthropic/claude-sonnet-4.5")
    assert(config.behaviour.auto_suggestions == false)
    state.set("test.unrelated", "preserve")
    config.override({
        providers = { openrouter = { model = "test/chat-model" } },
    })
    assert(config.save_last_model("test/chat-model", "openrouter"))
    toggles.set("ai_selection", false)
    assert(not toggles.enabled("ai_selection"))
    toggles.set("ai_suggestion", true)
    assert(toggles.enabled("ai_suggestion"))
    toggles.set("ai_suggestion", false)
    assert(not toggles.enabled("ai_suggestion"))
    -- 旧文件即使存在也不能覆盖统一偏好。
    local legacy = vim.fn.stdpath("state") .. "/avante/config.json"
    vim.fn.mkdir(vim.fn.fnamemodify(legacy, ":h"), "p")
    vim.fn.writefile({
        vim.json.encode({
            last_provider = "openrouter",
            last_model = "test/stale",
        }),
    }, legacy)
elseif phase == "read" then
    assert(config.provider == "openrouter")
    assert(
        config.providers.openrouter.model == "test/chat-model",
        "chat selection not restored"
    )
    assert(
        not toggles.enabled("ai_selection"),
        "selection preference not restored"
    )
    assert(
        not toggles.enabled("ai_suggestion"),
        "suggestion preference not restored"
    )
    assert(
        state.get("test.unrelated") == "preserve",
        "unrelated state was lost"
    )
else
    error("unknown phase " .. phase)
end
assert(
    config.providers[provider].model == suggestion_model,
    "chat selection changed suggestion model"
)
assert(
    not config.save_last_model(suggestion_model, provider),
    "hidden suggestion provider saved as chat"
)
print(
    "PASS: Avante preferences "
        .. phase
        .. ", independent suggestion model and toggle state"
)
vim.cmd("qa!")
