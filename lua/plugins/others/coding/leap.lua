--- Plugin settings: comment
-- @author monten (monten.oki@gmail.com)
-- @license MIT
-- @copyright monten.oki 2024

local keys = require('keymaps')
return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  keys = {
    {
      keys.leap.toggle,
      function()
        local leap = require('leap')
        leap.leap({
          target_windows = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0)),
        })
      end,
      desc = 'Toggle Leap',
    },
  },
  config = function(_, opts)
    local leap = require('leap')
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
  end,
}
