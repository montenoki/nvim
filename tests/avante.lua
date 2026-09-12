-- 只验证本地配置与 UI/补全，不发送模型请求，不读取或打印密钥。
require("lazy").load({ plugins = { "avante.nvim", "blink.cmp" } })
vim.wait(200, function()
    return false
end)
local config = require("avante.config")
assert(config.selector.provider == "snacks")
assert(config.input.provider == "snacks")
assert(config.providers.openrouter.timeout == 120000)
assert(config.instructions_file == "avante.md")
local plugins = require("lazy.core.config").plugins
for _, name in ipairs({ "nvim-cmp", "mini.pick", "dressing.nvim" }) do
    assert(plugins[name] == nil, name)
end
assert(package.loaded.cmp == nil)
for _, name in ipairs({
    "avante_templates",
    "avante_tokenizers",
    "avante_repo_map",
    "avante_html2md",
}) do
    assert(pcall(require, name), name)
end
local blink = require("blink.cmp.config")
assert(blink.keymap["<Tab>"][1] == "select_next")
assert(blink.snippets.preset == "luasnip")
assert(blink.sources.per_filetype.AvanteInput[1] == "avante")
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
local clip = require("img-clip.config")
vim.cmd("noautocmd setlocal filetype=markdown")
assert(clip.get_opt("use_absolute_path", {}) == false)
vim.cmd("noautocmd setlocal filetype=AvanteInput")
assert(clip.get_opt("use_absolute_path", {}) == true)
print(
    "Avante dependencies, native modules, Blink completions and image paths passed"
)
vim.cmd("qa!")
