local Keys = require('keymaps')
return {
  'folke/todo-comments.nvim',
  cond = vim.g.vscode == nil and vim.g.lite,
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }, -- LazyFile
  opts = {
    keywords = {
      TODO = { icon = '󰀡', color = 'info' },
      NOTE = { icon = '', color = 'hint', alt = { 'INFO', 'NOTE', 'TIP' } },
      WARN = { icon = '', color = 'warning', alt = { 'WARNING', 'XXX' } },
      FIX = { icon = '', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
    },
    highlight = {
      pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
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
      pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  },
  keys = {
    -- { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    -- { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    -- { '<LEADER>xt', '<CMD>TodoTrouble<CR>', desc = 'Todo (Trouble)' },
    -- { '<LEADER>xT', '<CMD>TodoTrouble keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme (Trouble)' },
    { Keys.todo.show_todo, '<CMD>TodoTelescope keywords=TODO<CR>', desc = 'Todo' },
    { Keys.todo.show_all, '<CMD>TodoTelescope keywords=TODO,FIX,FIXME<CR>', desc = 'Todo/Fix/Fixme' },
  },
}
