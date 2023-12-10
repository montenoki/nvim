local uConfig = require('uConfig')
local comment = requirePlugin('Comment')
if comment == nil or not uConfig.enable.comment_toggle then
    return
end

local keys = uConfig.keys.comment_toggle

local opts = {
    mappings = {
        extra = false,
    },
    toggler = {
        line = keys.toggler.line,
        block = keys.toggler.block,
    },
    opleader = {
        line = keys.opleader.line,
        bock = keys.opleader.block,
    },
}

comment.setup(opts)
