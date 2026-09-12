-- 使用同一隔离 state 目录，依次以 SHOWKEYS_TEST_MODE=write/read 运行。
require("lazy").load({ plugins = { "showkeys", "lualine.nvim" } })
local toggles = require("config.toggles")
local state = require("config.state")
local plugin_state = require("showkeys.state")
local button = require("lualine").get_config().sections.lualine_z[9]
if vim.env.SHOWKEYS_TEST_MODE == "read" then
    assert(toggles.enabled("showkeys"), "没有恢复开启状态")
    vim.cmd.ShowkeysToggle()
    assert(not toggles.enabled("showkeys"))
    assert(state.get("toggle.showkeys") == false)
else
    assert(not toggles.enabled("showkeys"), "首次应默认关闭")
    button.on_click()
    assert(toggles.enabled("showkeys"))
    assert(state.get("toggle.showkeys") == true)
    vim.api.nvim_feedkeys("l", "xt", false)
    assert(vim.wait(500, function() return plugin_state.win ~= nil end))
    assert(vim.api.nvim_win_get_config(plugin_state.win).relative == "editor")
    assert(vim.api.nvim_win_get_config(plugin_state.win).focusable == false)
    assert(#plugin_state.keys > 0, "浮窗没有捕获按键")
    -- 自动隐藏只清理浮窗，仍处于开启状态。
    require("showkeys.utils").clear_and_close()
    assert(toggles.enabled("showkeys"))
    button.on_click()
    assert(not toggles.enabled("showkeys"))
    assert(state.get("toggle.showkeys") == false)
    vim.cmd.ShowkeysToggle()
    assert(toggles.enabled("showkeys"))
    assert(state.get("toggle.showkeys") == true)
end
print("showkeys tests passed: " .. vim.env.SHOWKEYS_TEST_MODE)
vim.cmd("qa!")
