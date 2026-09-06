vim.opt.rtp:prepend(vim.fn.getcwd())
vim.notify = function() end
local state = require("config.state")
local toggles = require("config.toggles")
local utils = require("utils")
local actions = {
    diagnostics = utils.toggle_diagnostic,
    inlay_hints = utils.toggle_inlay_hints,
    codelens = utils.toggle_codelens,
    conceal = utils.toggle_conceal,
    spell = function()
        utils.toggle_option("spell")
    end,
    list = function()
        utils.toggle_option("list")
    end,
    relativenumber = function()
        utils.toggle_option("relativenumber")
    end,
    autoformat = function()
        utils.toggle_global("autoformat")
    end,
}
local enabled = vim.env.TOGGLE_TEST_MODE == "on"
toggles.setup()
if vim.env.TOGGLE_TEST_MODE == "restore" then
    for key in pairs(actions) do
        assert(toggles.enabled(key) == state.get("toggle." .. key), key)
    end
else
    state.set("theme", "kanagawa-dragon")
    for key, action in pairs(actions) do
        -- Exercise both transitions, regardless of Neovim's defaults.
        action()
        assert(toggles.enabled(key) == state.get("toggle." .. key), key)
        if toggles.enabled(key) ~= enabled then
            action()
        end
        assert(state.get("toggle." .. key) == enabled, key)
    end
end
assert(state.get("theme") == "kanagawa-dragon")

-- New buffers/windows and late ftplugin defaults must retain saved preferences.
vim.cmd("vnew")
vim.wo.spell = not state.get("toggle.spell")
vim.wo.conceallevel = state.get("toggle.conceal") and 0 or 2
vim.api.nvim_exec_autocmds("FileType", {})
vim.wait(50, function()
    return false
end)
assert(vim.wo.spell == state.get("toggle.spell"))
assert((vim.wo.conceallevel > 0) == state.get("toggle.conceal"))

-- Simulate LazyVim's delayed capability callback using the real hint API.
local handlers = {}
_G.Snacks = {
    util = {
        lsp = {
            on = function(filter, callback)
                handlers[filter.method] = callback
            end,
        },
    },
}
toggles.configure_lsp({
    inlay_hints = { enabled = true, exclude = { "vue" } },
    codelens = { enabled = false },
})
local buf = vim.api.nvim_get_current_buf()
handlers["textDocument/inlayHint"](buf)
assert(
    vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
        == state.get("toggle.inlay_hints")
)
utils.toggle_inlay_hints()
handlers["textDocument/inlayHint"](buf)
assert(
    vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
        == state.get("toggle.inlay_hints")
)
utils.toggle_inlay_hints()
print("toggle tests passed: " .. vim.env.TOGGLE_TEST_MODE)
