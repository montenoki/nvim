local uConfig = require('uConfig')
local uComment = uConfig.comment

if uComment == nil or not uComment.enable then
    return
end

local comment = requirePlugin('Comment')
if comment == nil then
    return
end

local opts = {
    mappings = {
        extra = false,
    },
    toggler = {
        line = uComment.toggler.line,
        block = uComment.toggler.block,
    },
    opleader = {
        line = uComment.opleader.line,
        bock = uComment.opleader.block,
    },
}

comment.setup(opts)
