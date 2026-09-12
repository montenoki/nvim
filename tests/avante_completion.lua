-- 验证 Avante 原生模块和 Blink 适配；不发送模型请求，不读取或打印密钥。
require("lazy").load({ plugins = { "avante.nvim", "blink.cmp" } })
vim.wait(200, function()
    return false
end)
for _, name in ipairs({
    "avante_templates",
    "avante_tokenizers",
    "avante_repo_map",
    "avante_html2md",
}) do
    assert(pcall(require, name), name)
end
local blink = require("blink.cmp.config")
local source =
    require("blink-cmp-avante").new(blink.sources.providers.avante.opts)
local function completions(ft, char)
    vim.cmd("noautocmd setlocal filetype=" .. ft)
    local result
    source:get_completions(
        { cursor = { 1, 1 }, trigger = { initial_character = char } },
        function(response)
            result = response.items
        end
    )
    return result
end
for _, trigger in ipairs({ "/", "@", "#" }) do
    assert(#completions("AvanteInput", trigger) > 0, trigger)
end
assert(#completions("AvantePromptInput", "@") > 0)
assert(#completions("AvantePromptInput", "/") == 0)
assert(#completions("lua", "@") == 0)
-- @file 接受动作仍转交 Avante 侧栏，不会变成普通字符串插入。
local avante = require("avante")
local original_get = avante.get
local opened = false
avante.get = function()
    return {
        file_selector = {
            open = function()
                opened = true
            end,
        },
    }
end
for _, item in ipairs(completions("AvanteInput", "@")) do
    if item.label == "@file" then
        source:execute({}, item, function() end, function()
            error("@file did not execute")
        end)
    end
end
avante.get = original_get
assert(opened)
print("PASS: Avante native modules, Blink completions and sidebar callbacks")
vim.cmd("qa!")
