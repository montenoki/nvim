-- 检查 Avante 的 config.override、模型保存回调及 toggle 接口，分两次启动验证恢复。
-- 不进入插入模式、不发送模型请求；不读取密钥。
require("lazy").load({ plugins = { "avante.nvim" } })
local config = require("avante.config")
local toggles = require("config.toggles")
local provider = "openrouter_suggestions"
local suggestion_model = config.providers[provider].model
local phase =
    assert(vim.env.NVIM_TEST_PHASE, "NVIM_TEST_PHASE must be write/read")
if phase == "write" then
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
elseif phase == "read" then
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
