--- Plugin settings: comment
-- @author monten (monten.oki@gmail.com)
-- @license MIT
-- @copyright monten.oki 2024

local keys = require('keymaps')
return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  cond = vim.g.vscode == nil,
  opts = {
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = keys.comment.line,
      ---Block-comment toggle keymap
      block = keys.comment.block,
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = keys.comment.v_line,
      ---Block-comment keymap
      block = keys.comment.v_block,
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = keys.comment.above,
      ---Add comment on the line below
      below = keys.comment.below,
      ---Add comment at the end of line
      eol = keys.comment.eol,
    },
  },
}
