local leap = requirePlugin('leap')
local uConfig = require('uConfig')
local keys = uConfig.keys.leap

if leap == nil or not uConfig.enable.leap then
    return
end
require('leap').leap({ target_windows = { vim.fn.win_getid() } })

-- Searching in all windows (including the current one) on the tab page.
vim.keymap.set({ 'n', 'v' }, keys.toggle, function()
    require('leap').leap({
        target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
        end, vim.api.nvim_tabpage_list_wins(0)),
    })
end)
