local hop = requirePlugin('hop')
local uConfig = require('uConfig')
local keys = uConfig.keys.hop

if hop == nil or not uConfig.enable.hop then
    return
end

hop.setup({
    multi_windows = true,
    keys = 'asdghjkl;qwertyuiopzxcvbnm',
})

keymap('', keys.toggle, '<CMD>HopAnywhere<CR>')
