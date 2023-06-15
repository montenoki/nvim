local todo = requirePlugin('todo-comments')
local uConfig = require('uConfig')
local lite_mode = uConfig.enable.lite_mode
if todo == nil or not uConfig.enable.todo_comments then
    return
end

local keywords_setting

if lite_mode then
    keywords_setting = {
        TODO = { icon = '=>', color = 'info' },
        NOTE = { icon = ':>', color = 'hint', alt = { 'INFO' } },
        WARN = { icon = '! ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        FIX = { icon = '!!', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
    }
else
    keywords_setting = {
        TODO = { icon = '', color = 'info' },
        NOTE = { icon = '', color = 'hint', alt = { 'INFO', 'NOTE' } },
        WARN = { icon = '', color = 'warning', alt = { 'WARNING', 'XXX' } },
        FIX = { icon = '󰈸', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
    }
end

-- TODO
-- NOTE
-- WARNING
-- FIX

todo.setup({
    keywords = keywords_setting,
    highlight = {
        pattern = [[.*<(KEYWORDS)]],
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
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
})
