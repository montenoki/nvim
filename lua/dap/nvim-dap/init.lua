-- local dap_install = require("dap-install")
-- dap_install.setup({
--   installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
-- })
local uConfig = require('uConfig')
local keys = uConfig.keys.dap
local dap = requirePlugin('dap')
local vt = requirePlugin('nvim-dap-virtual-text')
local opt = { noremap = true, silent = true }

if dap == nil or vt == nil then
    return
end

vt.setup({
    commented = true,
})

keymap('n', keys.toggle, '<CMD>lua require("dapui").toggle()<CR>')
keymap('n', keys.run, "<CMD>lua require('dap').run()<CR>")
keymap('n', keys.breakpoint_toggle, "<CMD>lua require('dap').toggle_breakpoint()<CR>")
keymap('n', keys.breakpoint_clear, "<CMD>lua require('dap').clear_breakpoints()<CR>")
-- continue
keymap('n', keys.continue, "<CMD>lua require('dap').continue()<CR>")
--  stepOver, stepOut, stepInto
keymap('n', keys.step_into, "<CMD>lua require'dap'.step_into()<CR>")
keymap('n', keys.step_over, "<CMD>lua require'dap'.step_over()<CR>")
keymap('n', keys.step_out, "<CMD>lua require'dap'.step_out()<CR>")
keymap('n', keys.restart, "<CMD>lua require'dap.restart()<CR>")

keymap('n', keys.open_info, "<CMD>lua require'dapui'.eval()<cr>")
-- Stop
keymap(
    'n',
    keys.stop,
    "<CMD>lua require'dap'.close()<CR>"
        .. "<CMD>lua require'dap'.terminate()<CR>"
        .. "<CMD>lua require'dap.repl'.close()<CR>"
        .. "<CMD>lua require'dapui'.close()<CR>"
        .. "<CMD>lua require('dap').clear_breakpoints()<CR>"
        .. '<C-w>o<CR>',
    opt
)

require('dap.nvim-dap.ui')
require('dap.nvim-dap.config.python')
require('dap.nvim-dap.config.lua')
