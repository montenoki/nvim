local fidget = requirePlugin('fidget')
local uConfig = require('uConfig')

if fidget == nil then
    return
end

local done_mark
if uConfig.lite_mode then
    done_mark = 'v'
else
    done_mark = '✔'
end

fidget.setup({
    text = {
        spinner = 'bouncing_bar',
        done = done_mark, -- character shown when all tasks are complete
        commenced = 'Started', -- message shown when task starts
        completed = 'Completed', -- message shown when task completes
    },
    sources = {
        ['null-ls'] = {
            ignore = true,
        },
    },
})
