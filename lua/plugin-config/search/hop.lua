local hop = requirePlugin('hop')
if hop == nil then
    return
end

hop.setup({
    multi_windows = true,
    keys = 'asdghjkl;qwertyuiopzxcvbnm',
})
