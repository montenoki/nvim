local todo = requirePlugin('todo-comments')
local uConfig = require('uConfig')
local lite_mode = uConfig.lite_mode
if todo == nil then
    return
end

todo.setup({
    keywords = {
        if lite_mode then
            TODO = { icon = '? ', color = 'info' },
            NOTE = { icon = '::', color = 'hint', alt = { 'INFO' } },
            WARN = { icon = '! ', color = 'warning', alt = { 'WARNING', 'XXX' } },
            FIX = { icon = '! ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
        else
            TODO = { icon = ' ', color = 'info' },
            NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
            WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
            FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
        end
        },
    search = {
        command = 'rg',
        args = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
})
