local Keys = require('keymaps').comment
return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  cond = vim.g.vscode == nil,
  opts = {
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = Keys.line,
      ---Block-comment toggle keymap
      block = Keys.block,
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = Keys.v_line,
      ---Block-comment keymap
      block = Keys.v_block,
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = Keys.above,
      ---Add comment on the line below
      below = Keys.below,
      ---Add comment at the end of line
      eol = Keys.eol,
    },
  },
}
