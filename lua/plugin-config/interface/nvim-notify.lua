local notify = requirePlugin('notify')
if notify == nil then
    return
end

notify.setup({
    stages = 'static',
    timeout = 1000,
})
vim.notify = notify
