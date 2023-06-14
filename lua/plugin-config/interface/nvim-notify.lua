local notify = requirePlugin('notify')
local uConfig = require('uConfig')
if notify == nil or not uConfig.enable.notify then
    return
end

notify.setup({
    stages = 'static',
    timeout = 1000,
})
vim.notify = notify
