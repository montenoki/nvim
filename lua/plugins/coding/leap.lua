local Keys = require('keymaps').leap
return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  keys = {
    {
      Keys.toggle,
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
    -- Define equivalence classes for brackets and quotes, in addition to the default whitespace group.
    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    -- Override some old defaults - use backspace instead of tab (see issue #165).
    -- leap.opts.special_keys.prev_target = '<backspace>'
    -- leap.opts.special_keys.prev_group = '<backspace>'
    -- Use the traversal keys to repeat the previous motion without explicitly invoking Leap.
    -- require('leap.user').set_repeat_keys('<enter>', '<backspace>')
  end,
}
