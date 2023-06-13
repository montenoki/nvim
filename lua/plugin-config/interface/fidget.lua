local fidget = requirePlugin('fidget')
local uConfig = require('uConfig')

if fidget == nil then
    return
end

local done_mark
local anime

if uConfig.enable.lite_mode then
    done_mark = 'Done'
    anime = 'bouncing_bar'
else
    done_mark = '✔'
    anime = 'clock'
end

fidget.setup({
    text = {
        spinner = anime,
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
