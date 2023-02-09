-- local dap_install = require("dap-install")
-- dap_install.setup({
--   installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- })
local dap = requirePlugin('dap')
if dap == nil then
    return
end

local vt = requirePlugin('nvim-dap-virtual-text')
if vt == nil then
    return
end

require('dap.nvim-dap.ui')

vt.setup({
    commented = true,
})
dap.set_log_level('TRACE')

require('dap.nvim-dap.config.python')

require('keybindings').mapDAP()
