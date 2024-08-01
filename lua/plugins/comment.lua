local keymaps = require('keymaps')

return {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    init = function()
        vim.keymap.del('n', 'gc')
        vim.keymap.del('n', 'gcc')
        vim.keymap.del('o', 'gc')
        vim.keymap.del('x', 'gc')
    end,
    opts = {
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
            ---Line-comment toggle keymap
            line = keymaps.comment.line,
            ---Block-comment toggle keymap
            block = keymaps.comment.block,
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = keymaps.comment.v_line,
            ---Block-comment keymap
            block = keymaps.comment.v_block,
        },
        ---LHS of extra mappings
        extra = {
            ---Add comment on the line above
            above = keymaps.comment.above,
            ---Add comment on the line below
            below = keymaps.comment.below,
            ---Add comment at the end of line
            eol = keymaps.comment.eol,
        },
    },
}
