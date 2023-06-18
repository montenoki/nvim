-- local dap_install = require("dap-install")
-- dap_install.setup({
--   installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- })
local dap = requirePlugin('dap')
local vt = requirePlugin('nvim-dap-virtual-text')

if dap == nil or vt == nil then
    return
end

vt.setup({
    commented = true,
})

require('dap.nvim-dap.config.python')

require('keybindings').mapDAP()
require('dap.nvim-dap.ui')
