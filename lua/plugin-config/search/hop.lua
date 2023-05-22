local hop = requirePlugin('hop')
if hop == nil then
    return
end

hop.setup({
    multi_windows = true,
    keys = 'asdghjkl;qwertyuiopzxcvbnm',
})

vim.keymap.set('', '\\', function()
    hop.hint_anywhere()
end, { remap = true })
