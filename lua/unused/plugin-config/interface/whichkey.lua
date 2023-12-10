local uConfig = require('uConfig')
local which_key = requirePlugin('which-key')
local keys = uConfig.keys.which_key
if which_key == nil or not uConfig.enable.which_key then
    return
end

which_key.setup({
    plugins = {
        presets = {
            operators = false,
        },
    },
})
-- which-key
keymap({ 'n', 'v' }, keys.toggle, '<CMD>WhichKey<CR>')
